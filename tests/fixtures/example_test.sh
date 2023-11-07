

test_sum_1_plus_1() {
  assert_equals 2 $(1 + 1)
}

function test_sum_2_plus_2() {
  assert_equals 4 $(2 + 2)
}

this_is_not_a_test() {
  echo "This is not a test"
}

