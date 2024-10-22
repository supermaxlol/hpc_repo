import multiprocessing
from time import time
from multiprocessing import Process

def do_work(process_number):
    start_time = time()  # Record start time
    print(f"[Process {process_number}] Starting work at {start_time:.2f}")
    
    i = 0
    for _ in range(20000000):
        i += 1
    
    end_time = time()  # Record end time
    print(f"[Process {process_number}] Finished work at {end_time:.2f}. Response time: {end_time - start_time:.2f} seconds")

if __name__ == '__main__':
    
    multiprocessing.set_start_method('spawn')
    
    processes = []
    
    # Start processes
    for process_number in range(1, 6):
        p = Process(target=do_work, args=(process_number,))
        processes.append(p)
        p.start()
        print(f"[Process {process_number}] Started.")
    
    # Join processes and count how many have finished
    completed_count = 0
    for process_number, p in enumerate(processes, 1):
        p.join()  # Ensure each process completes
        completed_count += 1
        print(f"[Process {process_number}] Joined. Total processes joined: {completed_count}/5")
    
    print(f"All {completed_count} processes completed.")
