! PR 87939
! { dg-do compile }
! { dg-options "-fcoarray=lib -fdump-tree-original" }
!
! Test critical construct with stat= and errmsg= specifiers
!
  use, intrinsic :: iso_fortran_env, only: int16
  implicit none
  integer :: istat
  integer(kind=int16) :: istat16
  character(len=30) :: err

  critical (stat=istat, errmsg=err)
    continue
  end critical
end

! { dg-final { scan-tree-dump "_gfortran_caf_lock \\(caf_token.\[0-9\]+, 0, 1, 0B, &istat, &err, 30\\);" "original" } }
! { dg-final { scan-tree-dump "istat = istat != 6002 \\? istat != 6001 \\? istat : 6002 : 6001;" "original" } }
! { dg-final { scan-tree-dump "_gfortran_caf_unlock \\(caf_token.\[0-9\]+, 0, 1, &stat.\[0-9\]+, 0B, 0\\);" "original" } }
