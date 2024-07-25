; ModuleID = 'float_test.c'
source_filename = "float_test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
; CHECK-LABEL: @float_test
define dso_local float @float_test(i32 noundef %0, float noundef %1) #0 {
  %3 = icmp slt i32 %0, 0
  br i1 %3, label %4, label %7

4:                                                ; preds = %2
  %5 = fmul float %1, %1
  %6 = fmul float %5, 2.000000e+00
  br label %10

7:                                                ; preds = %2
  %8 = fmul float %1, %1
  %9 = fmul float %8, 3.000000e+00
  br label %10

10:                                               ; preds = %7, %4
  %11 = phi float [ %6, %4 ], [ %9, %7 ]
  ret float %11
  ; CHECK: fmul
  ; CHECK: fmul
  ; CHECK: fmul
  ; CHECK-NOT: fmul
  ; CHECK: ret
}

; Function Attrs: nounwind uwtable
; CHECK-LABEL: @nested_for
define dso_local i32 @nested_for(i32 noundef %0) #0 {
  br label %2

2:                                                ; preds = %14, %1
  %3 = phi i32 [ 0, %1 ], [ %10, %14 ]
  %4 = phi i32 [ 0, %1 ], [ %15, %14 ]
  %5 = mul nsw i32 %0, %0
  %6 = icmp slt i32 %4, %5
  br i1 %6, label %8, label %7
  ; CHECK: mul

7:                                                ; preds = %2
  ret i32 %3

8:                                                ; preds = %2
  br label %9

9:                                                ; preds = %16, %8
  %10 = phi i32 [ %3, %8 ], [ %18, %16 ]
  %11 = phi i32 [ 0, %8 ], [ %19, %16 ]
  %12 = mul nsw i32 %0, %0
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %16, label %14
  ; CHECK-NOT : mul

14:                                               ; preds = %9
  %15 = add nsw i32 %4, 1
  br label %2

16:                                               ; preds = %9
  %17 = mul nsw i32 %0, %0
  %18 = add nsw i32 %10, %17
  %19 = add nsw i32 %11, 1
  br label %9
  ; CHECK-NOT: mul 
}

; Function Attrs: nounwind uwtable
; CHECK-LABEL: @for_if_else
define dso_local i32 @for_if_else(i32 noundef %0, i32 noundef %1) #0 {
  %3 = mul nsw i32 %0, %1
  br label %4
  ; CHECK: mul

4:                                                ; preds = %20, %2
  %5 = phi i32 [ %3, %2 ], [ %21, %20 ]
  %6 = phi i32 [ 0, %2 ], [ %22, %20 ]
  %7 = mul nsw i32 %0, %0
  %8 = icmp slt i32 %6, %7
  br i1 %8, label %10, label %9
  ; CHECK: mul

9:                                                ; preds = %4
  ret i32 %5

10:                                               ; preds = %4
  %11 = mul nsw i32 %0, %0
  %12 = icmp slt i32 %11, %6
  br i1 %12, label %13, label %17
  ; CHECK-NOT: mul

13:                                               ; preds = %10
  %14 = mul nsw i32 %0, %1
  %15 = add nsw i32 %14, %1
  %16 = add nsw i32 %5, %15
  br label %20
  ; CHECK-NOT: mul

17:                                               ; preds = %10
  %18 = mul nsw i32 %0, %1
  %19 = add nsw i32 %5, %18
  br label %20
  ; CHECK-NOT: mul

20:                                               ; preds = %13, %17
  %21 = phi i32 [ %16, %13 ], [ %19, %17 ]
  %22 = add nsw i32 %6, 1
  br label %4
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{!"Ubuntu clang version 14.0.0-1ubuntu1"}