target extended-remote localhost:3333
monitor reset halt
monitor arm semihosting enable
file bin/test
load
break main
run
finish
delete break
monitor shutdown
