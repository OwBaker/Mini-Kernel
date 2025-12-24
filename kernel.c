/*
kernel.c
at the moment, all the kernel does is clear the screen, and then write the string "leKernel" to it
*/
void kmain(void){
    //declare the string to put on screen
    const char *str = "LeKernel";
    //first, make a pointer that points to the start of video memory in protected mode
    char *vidptr = (char*)0xb8000;

    // loop control variables
    unsigned int i = 0;
    unsigned int j = 0;

    /* this first loop clears the screen
    the screen has 25 lines with 80 columns each, with each element taking 2 bytes
    the first byte corresponds to the character in ASCII
    the second byte corrresponds to the formatting of the character (background and color)
    */
    while(j < 80 * 25 * 2){
        /*set column to blank character*/
        vidptr[j] = ' ';
        /*set attribute of character*/
        vidptr[j+1] = 0x07; // 0 denotes the background color of black, and 7 denotes the foreground as light grey
        j = j + 2; // increment the lcv
    }

    // reset lcv for next loop
    j = 0;

    /*
    this loop writes the actual string to video memory
    */
    while(str[j] != '\0'){
        // set element to character's ascii
        vidptr[i] = str[j]; // first byte set to character
        // set element attributes
        vidptr[i+1] = 0x07;
        ++j; // increment j by 1 (goes to next character in string)
        i = i + 2; // increment i by 2 (goes to next 2 bytes of text video memory)
    }

    return;
}