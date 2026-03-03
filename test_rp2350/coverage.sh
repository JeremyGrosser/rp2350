#!/bin/bash

check_error() {
    ret=$?
    if [ ! $ret -eq 0 ]; then
        echo "$1" 1>&2
        exit $ret
    fi
}

alr clean
rm -rf ../obj obj
alr build --validation --
check_error "Build failed"

eval $(alr printenv)
gnatcov instrument -P test.gpr \
    --projects=RP2350 \
    --level=stmt+mcdc \
    --dump-trigger=main-end \
    --dump-channel=base64-stdout
check_error "Instrumentation failed"

alr clean
export GPR_PROJECT_PATH="${GPR_PROJECT_PATH}:${PWD}/gnatcov_rts"
gprbuild -P test.gpr \
    --src-subdirs=gnatcov-instr \
    --implicit-with=gnatcov_rts.gpr \
    -j0 \
    -f
check_error "Coverage build failed"

openocd \
    -f interface/cmsis-dap.cfg \
    -c "adapter speed 5000" \
    -c "set _USE_CORE 0" \
    -f target/rp2350.cfg \
    &>coverage.log &
timeout --verbose --signal=INT --kill-after=1s 120s arm-eabi-gdb --batch --command=coverage.gdb

let first=$(grep --text --line-number 'Testing...' coverage.log | head -n1 | cut -d':' -f1)
let last=$(grep --text --line-number '== GNATcoverage source trace file ==' coverage.log | head -n1 | cut -d':' -f1)
head -n $(($last-1)) coverage.log | tail -n $(($last-$first)) 1>&2

gnatcov extract-base64-trace coverage.log coverage.trace
COVERAGE_FLAGS=" \
    -P test.gpr \
    --projects=RP2350 \
    --no-subprojects \
    --level=stmt+mcdc \
    coverage.trace \
    "

gnatcov coverage --annotate=xcov+ ${COVERAGE_FLAGS}
gnatcov coverage --annotate=html+ ${COVERAGE_FLAGS}

let pass=$(grep --text '^PASS ' coverage.log | wc -l)
let fail=$(grep --text '^FAIL ' coverage.log | wc -l)
if [ $pass -gt 0 -a $fail -eq 0 ]; then
    echo "PASS" 1>&2
else
    echo "FAIL" 1>&2
fi
