#!/bin/zsh

function test() {
  # TODO: verbose
  echo $(date) $1 &>> $DOTFILES/log/test.log
  $1 &>> $DOTFILES/log/test.log
  if ((!$?)); then
    echo "\033[0;32m\u2714 Passed: $1\033[0m"
    return 0
  else
    echo "\033[0;31m\u2717 Failed: $1\033[0m"
    return 1
  fi
}

function draw-separator() {
  echo
  printf '\033[0;37m╴%.0s' {1..$COLUMNS}; echo "\033[0m\n"
}


local passed_all=0
local failed_all=0

for script in $DOTFILES/test/**/test_*.sh; do
  source $script
  local passed=0
  local failed=0
  draw-separator
  echo "\033[1;34mStart running test: ${script#*/}\033[0m\n"
  for func in ${$(grep "^function test_" $script | cut -d " " -f 2)//\(\)}; do
    test $func
    ((!$?)) && passed=$(( passed+1 )) || failed=$(( failed+1 ))
    echo
  done

  passed_all=$(( passed_all+passed ))
  failed_all=$(( failed_all+failed ))

  local result=""
  result+="\033[0;32m$passed\033[0m passed,"
  result+=" \033[0;31m$failed\033[0m failed"

  result+=" out of $(( passed + failed )) cases"
  echo "$result for ${script#*/}"
done

draw-separator
local result_all=""
result_all+="\033[0;32m$passed_all\033[0m passed,"
result_all+=" \033[0;31m$failed_all\033[0m failed"

result_all+=" out of $(( passed_all + failed_all )) cases"
echo "\033[1;34mOverall:\033[0m\n"
echo "$result_all"
draw-separator

[ $failed_all -eq 0 ] && return 0 || return 1
