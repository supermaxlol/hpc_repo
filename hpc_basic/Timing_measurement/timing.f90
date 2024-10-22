!///////////////////////////////////////////////////////////////////////////////////////////
!   Usage:
!           ./program -nx X  -nt T 
!           X:   number of gridpoints in x-direction (default = 1024)
!           T:   number of iterations to run for (default = 100)
!
!   Description:
!           Computes a[1:nx] = -a[1:nx] T times (nx = 128)
!           Reports time
!

Program Main
    USE ISO_FORTRAN_ENV, ONLY : output_unit
    IMPLICIT NONE


    !//////////////////////////////
    ! Timing variables
    INTEGER :: t1, t2, count_rate, count_max, i, j
    REAL*8  :: elapsed_time


    Integer, Parameter :: opu=output_unit
    Real*8, Allocatable :: a(:)


    !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    !   Problem Control Parameters
    Integer :: niter = 100000
    Integer :: nx = 128
    !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




    Call grab_args(niter)
    Allocate(a(1:nx))
    a = 1



    Write(opu,*)'niter: ', niter


    CALL System_Clock(t1, count_rate, count_max)
    Do j = 1, niter
        Do i = 1, nx
            a(i) = -a(i)
        Enddo
    Enddo

    CALL System_Clock(t2, count_rate, count_max)
    elapsed_time = real(t2-t1) / real(count_rate)


    Write(opu,*)'Elapsed time: ', elapsed_time





Contains

    SUBROUTINE grab_args(numiter)
            IMPLICIT NONE

            INTEGER, INTENT(INOUT)   :: numiter




            INTEGER :: n                    ! Number of command-line arguments
            INTEGER :: i                    
            CHARACTER(len=1024) :: argname  ! Argument key
            CHARACTER(len=1024) :: val      ! Argument value

            n = command_argument_count()
            DO i=1,n,2
                    CALL get_command_argument(i, argname)
                    CALL get_command_argument(i+1, val)
                    SELECT CASE(argname)
                            CASE('-niter')
                                    read(val, '(I8)') numiter
                            CASE DEFAULT
                                    WRITE(output_unit,'(a)') ' '
                                    WRITE(output_unit,'(a)') &
                                    ' Unrecognized option: '// trim(argname)
                    END SELECT
            ENDDO

    END SUBROUTINE grab_args


End Program Main
