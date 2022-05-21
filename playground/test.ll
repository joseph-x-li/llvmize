; ModuleID = 'testmodule'
source_filename = "testmodule"

define i64 @camlTest1__incr_261(i64 %0) {
"1":
  %1 = alloca i64, align 8
  store i64 %0, i64* %1, align 4
  br label %"100"

"100":                                            ; preds = %"1"
  %2 = load i64, i64* %1, align 4
  %3 = alloca i64, align 8
  store i64 %2, i64* %3, align 4
  %4 = load i64, i64* %3, align 4
  %5 = alloca i64, align 8
  store i64 %4, i64* %5, align 4
  %6 = load i64, i64* %5, align 4
  %7 = add i64 %6, 2
  store i64 %7, i64* %5, align 4
  %8 = load i64, i64* %5, align 4
  store i64 %8, i64* %1, align 4
  %9 = load i64, i64* %1, align 4
  ret i64 %9
}

define i64 @camlTest1__ident_263(i64 %0) {
"1":
  %1 = alloca i64, align 8
  store i64 %0, i64* %1, align 4
  br label %"103"

"103":                                            ; preds = %"1"
  %2 = load i64, i64* %1, align 4
  %3 = alloca i64, align 8
  store i64 %2, i64* %3, align 4
  %4 = load i64, i64* %3, align 4
  store i64 %4, i64* %1, align 4
  %5 = load i64, i64* %1, align 4
  ret i64 %5
}
