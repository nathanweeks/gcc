! PR 87939
! { dg-do compile }
! { dg-options "-fcoarray=lib -fdump-tree-original" }
!
! Test critical construct with (int16) stat= and errmsg= specifiers
!
  use, intrinsic :: iso_fortran_env, only: int16
  implicit none
  integer(kind=int16) :: istat
  character(len=30) :: err

  critical (stat=istat, errmsg=err)
    continue
  end critical
end

! { dg-final { scan-tree-dump "_gfortran_caf_lock \\(caf_token.\[0-9\]+, 0, 1, 0B, &stat.\[0-9\]+, &err, 30\\);" "original" } }
! { dg-final { scan-tree-dump "stat.\[0-9\]+ = stat.\[0-9\]+ != 6002 \\? stat.\[0-9\]+ != 6001 \\? stat.\[0-9\]+ : 6002 : 6001;" "original" } }
! { dg-final { scan-tree-dump "istat = \\(integer\\(kind=\[0-9\]+\\)\\) stat.\[0-9\]+" "original" } }
! { dg-final { scan-tree-dump "_gfortran_caf_unlock \\(caf_token.\[0-9\]+, 0, 1, &stat.\[0-9\]+, 0B, 0\\);" "original" } }
