#///////////////////////////////////////////////////////////////////////////////////////////
#   Usage:
#           python timing_ex_sol.py -nx X  -nt T 
#           X:   number of gridpoints in x-direction (default = 1024)
#           T:   number of iterations to run for (default = 100)
#
#   Description:
#           Computes a[1:nx] = -a[1:nx] T times (nx = 128)
#           Reports time
#

def main():
    from time import time
    import numpy

    def grab_args(args):
        import sys
        numarg = len(sys.argv)
        if (numarg > 1 and (numarg%2)==1):
            for i in range(numarg):
                if (sys.argv[i] == '-niter'):
                    args[0] = int(sys.argv[i+1])
        
    #////////////////////////////////
    # Read command-line arguments

    #defaults
    niter   = 100000 
    cadence = 10000  
    nx      = 1024 

    args = numpy.array([-1],dtype='int32')
    grab_args(args)

    if (args[0] > 0):
        niter = args[0]


    print('  niter:   ', niter)


    #////////////////////////////////
    # Initialize
    a = numpy.zeros(128,dtype='float64')

    a[:] = 1.0




    # Loop (and time)
    loop_start = time()



    for i in range(1,niter+1):
        
        a[:] = -a[:] 
   
    loop_end = time()

    print('  elapsed: ', loop_end-loop_start)



#############################
if ( __name__ == "__main__"):
    main()