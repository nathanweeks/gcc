! PR 87939
! { dg-do compile }
! { dg-options "-fcoarray=lib -fdump-tree-original" }
!
! Tests form team with stat= and errmsg=
!
  use iso_fortran_env, only : team_type
  implicit none
  integer :: istat, new_team
  character(len=30) :: err = "unchanged"
  type(team_type) :: team

  new_team = mod(this_image(),2)+1

  form team (new_team,team)
  form team (new_team,team,stat=istat)
  form team (new_team,team,stat=istat, errmsg=err)
  form team (new_team,team,new_index=1)
  form team (new_team,team,new_index=1,stat=istat)
  form team (new_team,team,new_index=1,stat=istat,errmsg=err)
end

! { dg-final { scan-tree-dump "_gfortran_caf_form_team \\(new_team, &team, 0B, 0B, 0B, 0\\)" "original" } }
! { dg-final { scan-tree-dump "_gfortran_caf_form_team \\(new_team, &team, 0B, &istat, 0B, 0\\)" "original" } }
! { dg-final { scan-tree-dump "_gfortran_caf_form_team \\(new_team, &team, 0B, &istat, &err, 30\\)" "original" } }
! { dg-final { scan-tree-dump "_gfortran_caf_form_team \\(new_team, &team, 1, 0B, 0B, 0\\)" "original" } }
! { dg-final { scan-tree-dump "_gfortran_caf_form_team \\(new_team, &team, 1, &istat, 0B, 0\\)" "original" } }
! { dg-final { scan-tree-dump "_gfortran_caf_form_team \\(new_team, &team, 1, &istat, &err, 30\\)" "original" } }
