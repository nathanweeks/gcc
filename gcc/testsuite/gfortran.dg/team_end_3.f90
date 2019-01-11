! PR 87939
! { dg-do compile }
! { dg-options "-fcoarray=lib -fdump-tree-original" }
!
! Tests end team stat= and errmsg= specifiers
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
  end team (stat=istat)

  change team (team)
    continue
  end team (stat=istat, errmsg=err)

end

! { dg-final { scan-tree-dump "_gfortran_caf_end_team \\(&istat, 0B, 0\\)" "original" } }
! { dg-final { scan-tree-dump "_gfortran_caf_end_team \\(&istat, &err, 30\\)" "original" } }
