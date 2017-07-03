
add log sim:/${module}_tb/finished

set tailtime 0
while {[examine sim:/${module}_tb/finished] == 0} {
  run 100 ns
  incr tailtime 10
}
run $tailtime ns