! ***********************************************************************
!
!   Copyright (C) 2010  The MESA Team
!
!   this file is part of mesa.
!
!   mesa is free software; you can redistribute it and/or modify
!   it under the terms of the gnu general library public license as published
!   by the free software foundation; either version 2 of the license, or
!   (at your option) any later version.
!
!   mesa is distributed in the hope that it will be useful, 
!   but without any warranty; without even the implied warranty of
!   merchantability or fitness for a particular purpose.  see the
!   gnu library general public license for more details.
!
!   you should have received a copy of the gnu library general public license
!   along with this software; if not, write to the free software
!   foundation, inc., 59 temple place, suite 330, boston, ma 02111-1307 usa
!
! ***********************************************************************
 
      module run_star_extras

      use star_lib
      use star_def
      use const_def
      use math_lib
      use auto_diff
      
      implicit none
      
      include "test_suite_extras_def.inc"

      
      contains

      include "test_suite_extras.inc"

      subroutine my_modified_momentum_implicit(id, ierr)
         use star_def
         use const_def, only: standard_cgrav
         implicit none
         integer, intent(in) :: id
         integer, intent(out) :: ierr
         type (star_info), pointer :: s
         integer :: k
         real(dp) :: rho_cms, G, r, enclosed_mass
         ierr = 0

         ! Constant
         rho_cms = 150.0_dp ! g/cm^3
         G = standard_cgrav

         call star_ptr(id, s, ierr)
         if (ierr /= 0) return

         do k = 1, s%nz
            ! Radius at zone k
            r = s%r(k)

            enclosed_mass = (4.0_dp / 3.0_dp) * pi * rho_cms * r**3

            ! Extra gravitational acceleration term: -G_grav * enclosed_mass / r^2
            s%extra_grav(k) = -G * enclosed_mass / r**2
         end do
      end subroutine my_modified_momentum_implicit
      
      subroutine my_modified_cgrav(id, ierr)
         use star_def
         use const_def, only: standard_cgrav
         use utils_lib, only: is_bad
         integer, intent(in) :: id
         integer, intent(out) :: ierr
         type(star_info), pointer :: s
         integer :: k
         real(dp) :: r, G, m, rho_cms
         include 'formats'
         ierr = 0
         rho_cms = 150.0_dp  ! rho_cms value in g/cm^3
         call star_ptr(id, s, ierr)
         if (ierr /= 0) return
         do k=1,s% nz
            r = s% r(k)
            G = standard_cgrav
            m = s% m(k) ! Gravitational mass hasn't been set when called
            if (m > 0.0_dp) then  ! Avoid division by zero
               s% cgrav(k) = G * (((4.0_dp / 3.0_dp) * pi * rho_cms * r**3 / m))
               !write(*,2) 'G/G_N', k, s% cgrav(k)/G
            else
               s% cgrav(k) = G
            end if
            if (is_bad(s% cgrav(k))) then
               write(*,2) 's% cgrav(k)', k, s% cgrav(k)
               write(*,2) 'r', k, r
               write(*,2) 'G', k, G
               write(*,2) 'm', k, m
               stop 'my_modified_cgrav'
            end if
         end do
         !write(*,*) 'done my_modified_cgrav', s% model_number
      end subroutine my_modified_cgrav


      subroutine extras_controls(id, ierr)
         integer, intent(in) :: id
         integer, intent(out) :: ierr
         type (star_info), pointer :: s
         ierr = 0
         call star_ptr(id, s, ierr)
         if (ierr /= 0) return

         s% other_cgrav => my_modified_cgrav
         s% other_momentum_implicit => my_modified_momentum_implicit

         s% extras_startup => extras_startup
         s% extras_check_model => extras_check_model
         s% extras_finish_step => extras_finish_step
         s% extras_after_evolve => extras_after_evolve
         s% how_many_extra_history_columns => how_many_extra_history_columns
         s% data_for_extra_history_columns => data_for_extra_history_columns
         s% how_many_extra_profile_columns => how_many_extra_profile_columns
         s% data_for_extra_profile_columns => data_for_extra_profile_columns  

      end subroutine extras_controls
      
      
      subroutine extras_startup(id, restart, ierr)
         integer, intent(in) :: id
         logical, intent(in) :: restart
         integer, intent(out) :: ierr
         type (star_info), pointer :: s
         ierr = 0
         call star_ptr(id, s, ierr)
         if (ierr /= 0) return
         call test_suite_startup(s, restart, ierr)
      end subroutine extras_startup
      
      
      subroutine extras_after_evolve(id, ierr)
         integer, intent(in) :: id
         integer, intent(out) :: ierr
         type (star_info), pointer :: s
         real(dp) :: dt
         ierr = 0
         call star_ptr(id, s, ierr)
         if (ierr /= 0) return
         call test_suite_after_evolve(s, ierr)
      end subroutine extras_after_evolve
      

      ! returns either keep_going, retry, or terminate.
      integer function extras_check_model(id)
         integer, intent(in) :: id
         integer :: ierr
         type (star_info), pointer :: s
         ierr = 0
         call star_ptr(id, s, ierr)
         if (ierr /= 0) return
         extras_check_model = keep_going         
      end function extras_check_model


      integer function how_many_extra_history_columns(id)
         integer, intent(in) :: id
         integer :: ierr
         type (star_info), pointer :: s
         ierr = 0
         call star_ptr(id, s, ierr)
         if (ierr /= 0) return
         how_many_extra_history_columns = 0
      end function how_many_extra_history_columns
      
      
      subroutine data_for_extra_history_columns(id, n, names, vals, ierr)
         integer, intent(in) :: id, n
         character (len=maxlen_history_column_name) :: names(n)
         real(dp) :: vals(n)
         integer, intent(out) :: ierr
         type (star_info), pointer :: s
         ierr = 0
         call star_ptr(id, s, ierr)
         if (ierr /= 0) return
      end subroutine data_for_extra_history_columns

      
      integer function how_many_extra_profile_columns(id)
         use star_def, only: star_info
         integer, intent(in) :: id
         integer :: ierr
         type (star_info), pointer :: s
         ierr = 0
         call star_ptr(id, s, ierr)
         if (ierr /= 0) return
         how_many_extra_profile_columns = 0
      end function how_many_extra_profile_columns
      
      
      subroutine data_for_extra_profile_columns(id, n, nz, names, vals, ierr)
         use star_def, only: star_info, maxlen_profile_column_name
         use const_def, only: dp
         integer, intent(in) :: id, n, nz
         character (len=maxlen_profile_column_name) :: names(n)
         real(dp) :: vals(nz,n)
         integer, intent(out) :: ierr
         type (star_info), pointer :: s
         integer :: k
         ierr = 0
         call star_ptr(id, s, ierr)
         if (ierr /= 0) return
      end subroutine data_for_extra_profile_columns
      

      ! returns either keep_going or terminate.
      integer function extras_finish_step(id)
         integer, intent(in) :: id
         integer :: ierr
         type (star_info), pointer :: s
         ierr = 0
         call star_ptr(id, s, ierr)
         if (ierr /= 0) return
         extras_finish_step = keep_going
      end function extras_finish_step
      
      

      end module run_star_extras
      
