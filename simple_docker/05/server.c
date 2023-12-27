#include <fcgi_stdio.h>
#include <stdio.h>

int main(void) {
    while (FCGI_Accept() >= 0) {
        printf("Content-Type: text/html\r\n");
        printf("Status: 200 OK\r\n\r\n");
        printf("Hello, World!\n");
    }
    return 0;
}