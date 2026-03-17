This commit includes the implementation of Baudrate Generator modules in Verilog.

1. Standard Baudrate Generator:
- Generates baud tick based on selected baud rate.
- Uses clock division technique.
- Supports standard UART baud rates: 9600, 19200, 38400, 57600, 115200.
- Each tick represents one UART bit duration.

2. Baudrate Generator with 16x Oversampling:
- Generates oversampling tick (16 times baud rate).
- Improves UART receiver accuracy.
- Helps handle clock mismatch, noise, and jitter.

3. Testbench:
- Verifies functionality for multiple baud rates.
- Uses 100 MHz clock.
- Simulates different baud selections.

This design is useful for UART communication and digital system timing generation.
