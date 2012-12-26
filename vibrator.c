#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>

// Just let them know we do not have a vibrator

int vibrator_exists()
{
 return(0);
}

// Succeed - no matter what

int sendit(int timeout_ms)
{
 return(0);
}
