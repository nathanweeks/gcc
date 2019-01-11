! PR 87939
! { dg-do compile }
! { dg-options "-fcoarray=lib -fdump-tree-original" }
!
! Test sync team statement
!
  use iso_fortran_env, only : team_type
  implicit none
  integer :: istat
  type(team_type) :: team
  character(len=30) :: err = "unchanged"

  form team (mod(this_image(),2)+1, team)

  change team (team)
    sync team (team)
    sync team (team, stat=istat)
    sync team (team, stat=istat, errmsg=err)
  end team
end

! { dg-final { scan-tree-dump "_gfortran_caf_sync_team \\(&team, 0B, 0B, 0\\)" "original" } }
! { dg-final { scan-tree-dump "_gfortran_caf_sync_team \\(&team, &istat, 0B, 0\\)" "original" } }
! { dg-final { scan-tree-dump "_gfortran_caf_sync_team \\(&team, &istat, &err, 30\\)" "original" } }
