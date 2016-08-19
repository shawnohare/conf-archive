#!/bin/sh
setup() {
  # this assumes we run bats tests from the root containing core.sh
  . exists.sh
}

@test "exists" {
  # file exists
  run exists "file" "core.sh"
  [ "${status}" -eq 0 ]

  # file does not exist
  run exists "file" "falsdjfalksjf"
  [ "${status}" -eq 1 ]

  # dir exists
  mkdir "tmp1234"
  run exists "dir" "tmp1234"
  [ "${status}" -eq 0 ]

  # dir exists
  rmdir "tmp1234"
  run exists "dir" "tmp1234"
  [ "${status}" -eq 1 ]

  # link exists
  ln -s core.sh core.link
  run exists "link" "core.link"
  [ "${status}" -eq 0 ]

  # link does not exist
  rm core.link
  run exists "link" "core.link"
  [ "${status}" -eq 1 ]

  # command exists
  run exists "cmd" "bats"
  [ "${status}" -eq 0 ]

  # command does not exist
  run exists "cmd" "falsdfjaklsfj"
  [ "${status}" -eq 1 ]

  # bad type
  run exists "-unsupported" "../core.shfilealksdjf"
  [ "${status}" -eq 2 ]

  # no object 
  run exists "file" 
  [ "${status}" -eq 2 ]
}

@test "require" {
  . core.sh
  run require "file" "core.sh"
  [ "${status}" -eq 0 ]

  run require "cmd" "fasldfj"
  [ "${status}" -eq 1 ]
}
