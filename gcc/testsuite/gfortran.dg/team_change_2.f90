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

  change team ! { dg-error "Syntax error in CHANGE TEAM statement" }
    continue
  end team

  change team (err) ! { dg-error "must be a scalar TEAM_TYPE expression" }
    continue
  end team

  change team (team, stat=err) ! { dg-error "must be a scalar INTEGER" }
    continue
  end team

  change team (team, stat=istat, stat=istat) ! { dg-error "Redundant STAT" }
    continue
  end team

  change team (team, stat=istat, errmsg=istat) ! { dg-error "must be a scalar CHARACTER variable" }
    continue
  end team

  change team (team, stat=istat, errmsg=str, errmsg=str) ! { dg-error "Redundant ERRMSG" }
    continue
  end team
end

