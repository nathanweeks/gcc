! PR 87939
! { dg-do compile }
! { dg-options "-fcoarray=lib -fdump-tree-original" }
!
! Tests change team stat= and errmsg= specifiers
!
  use iso_fortran_env, only : team_type
  implicit none
  type(team_type) :: team
  integer :: new_team, istat
  character(len=30) :: err

  new_team = mod(this_image(),2)+1

  form team (new_team,team)

  change team (team, stat=istat)
    continue
  end team

  change team (team, stat=istat, errmsg=err)
    continue
  end team

end

! { dg-final { scan-tree-dump "_gfortran_caf_change_team \\(&team, &istat, 0B, 0\\)" "original" } }
! { dg-final { scan-tree-dump "_gfortran_caf_change_team \\(&team, &istat, &err, 30\\)" "original" } }
