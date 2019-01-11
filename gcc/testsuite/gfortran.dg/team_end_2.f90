! PR 87939
! { dg-do compile }
! { dg-options "-fcoarray=lib" }
!
! Tests change team syntax
!
  use iso_fortran_env, only : team_type
  implicit none
  type(team_type) :: team
  integer :: new_team, istat
  character(len=30) :: err

  new_team = mod(this_image(),2)+1

  form team (new_team,team)

  change team (team)
    continue
  end team (stat=err) ! { dg-error "must be a scalar INTEGER" }

  change team (team)
    continue
  end team (stat=istat, stat=istat) ! { dg-error "Redundant STAT" }

  change team (team)
    continue
  end team (stat=istat, errmsg=istat) ! { dg-error "must be a scalar CHARACTER variable" }

  change team (team)
    continue
  end team (stat=istat, errmsg=str, errmsg=str) ! { dg-error "Redundant ERRMSG" }
end

