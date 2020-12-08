! ***********************************************************************
!
!   Copyright (C) 2010  Bill Paxton
!
!   MESA is free software; you can use it and/or modify
!   it under the combined terms and restrictions of the MESA MANIFESTO
!   and the GNU General Library Public License as published
!   by the Free Software Foundation; either version 2 of the License,
!   or (at your option) any later version.
!
!   You should have received a copy of the MESA MANIFESTO along with
!   this software; if not, it is available at the mesa website:
!   http://mesa.sourceforge.net/
!
!   MESA is distributed in the hope that it will be useful,
!   but WITHOUT ANY WARRANTY; without even the implied warranty of
!   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
!   See the GNU Library General Public License for more details.
!
!   You should have received a copy of the GNU Library General Public License
!   along with this software; if not, write to the Free Software
!   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
!
! ***********************************************************************
 
      module other_remove_surface

      ! consult star/other/README for general usage instructions
      ! control name: use_other_remove_surface = .true.
      ! procedure pointer: s% other_remove_surface => my_routine


      use star_def

      implicit none
      
            
      contains
      
      
      subroutine default_other_remove_surface(id, ierr, k)
         integer, intent(in) :: id
         integer, intent(out) :: ierr
         integer, intent(out) :: k

         type (star_info), pointer :: s
         ierr = 0
         call star_ptr(id, s, ierr)
         if (ierr /= 0) return

         k = 0 ! The cell to remove down to.
      end subroutine default_other_remove_surface


      end module other_remove_surface
      
      
      
      