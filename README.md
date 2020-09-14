# Fibonacci_VHDL
Fibbonaci calculator contains 8 files

1)2 to 1 mux(mux2x1)
2)register(reg)
3)8 bit adder(adder)
4)8 bit comparator(comparator)
5)controller(controller)
6)datapath(datapath)
7)fibonacci(fibonacci)
8)testbench(fibonacci_tb)

datapath contains connections to make the module using the first four.
Controller has the FSM_D which has the state diagrams (S_0,S_1,S_2,S_3,S_4,S_5)

fibonacci is used to connect the the datapath and controller



The calculator is giving output.Use testbench to change values. By default there are 3 values.
If making changes to the testbench keep track of clock cycle set at 5 ns, as it can cause done to never be 1 if reset delay is long.
