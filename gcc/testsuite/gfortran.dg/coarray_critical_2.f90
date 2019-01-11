! PR 87939
! { dg-do compile }
! { dg-options "-fcoarray=lib" }
!
! Test critical syntax errors with stat= and errmsg= specifiers
!
  implicit none
  integer :: istat
  character(len=30) :: err

  critical (stat=err) ! { dg-error "must be a scalar INTEGER" }
    continue
  end critical

  critical (stat=istat, stat=istat) ! { dg-error "Redundant STAT" }
    continue
  end critical

  critical (stat=istat, errmsg=istat) ! { dg-error "must be a scalar CHARACTER variable" }
    continue
  end critical

  critical (stat=istat, errmsg=err, errmsg=err) ! { dg-error "Redundant ERRMSG" }
    continue
  end critical

end
