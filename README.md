# st-builder
Build with squares and triangles within an 8086 assembly language project.

![alt text](https://github.com/lucianodainic/st-builder/blob/main/demo.png)

To run the asm program on ubuntu you will need to: 
* install DOSBox: sudo apt-get install dosbox; 
* download [Turbo Assembler (TASM)](https://sourceforge.net/projects/tasmeditor/files/latest/download?source=files) and [Turbo Debugger (TD)](https://winworldpc.com/product/borland-c/20); 
* create one directory and unzip the TASM archive into that directory; 
* unzip TD archive and move the files to /tasmeditor/TASM folder;
* place the st-builder.asm file into /tasmeditor/TASM folder; 
* open DOSBox and run mount c /home/<username> then c: ; 
* cd to the TASM directory; 
* run the program by the following commands: 
  * tasm st-builder.asm, 
  * tlink st-builder, 
  * st-builder; 
* press s or t to show a square or a triangle on the screen and move them arround with the arrow keys, exit by pressing other keys.
