#include <errno.h>
#include <fcntl.h>
#include <time.h>
#include <linux/videodev2.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <unistd.h>
#include "pngwriter.h"

//odkomentujte nasledovny riadok ak kamera nepodporuje BGR format
//pozri v4l2-ctl -d /dev/videoX --list-formats

//#define POUZI_YUV

uint8_t *buffer;


float x, y;

int sirka = 320;
int vyska = 240;
 
long long usec()
{
  struct timeval tv;
  gettimeofday(&tv, 0);
  return (1000000L * (long long)tv.tv_sec) + tv.tv_usec;
}

static int xioctl(int fd, int request, void *arg)
{
        int r;
 
        do r = ioctl (fd, request, arg);
        while (-1 == r && EINTR == errno);
 
        return r;
}
 
int setup_format(int fd)
{
        struct v4l2_format fmt = {0};
        fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        fmt.fmt.pix.width = sirka;
        fmt.fmt.pix.height = vyska;
        
        // ak vasa kamera nepodporuje BGR24, m ozno podporuje YUV420,
        // ale v tom pripade bude treba obrazok spracovavat v tom
        // formate, alebo si ho skonvertovat...

#ifdef POUZI_YUV
        fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_YUV420;
#else
        fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_BGR24;
#endif

        fmt.fmt.pix.field = V4L2_FIELD_NONE;
        
        if (-1 == xioctl(fd, VIDIOC_S_FMT, &fmt))
        {
            perror("nepodarilo sa nastavit format");
            return 1;
        }

        return 0;
}
 
int init_mmap(int fd)
{
    struct v4l2_requestbuffers req = {0};
    req.count = 1;
    req.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    req.memory = V4L2_MEMORY_MMAP;
 
    if (-1 == xioctl(fd, VIDIOC_REQBUFS, &req))
    {
        perror("nepodarilo sa inicializovat mmap buffer");
        return 1;
    }
 
    struct v4l2_buffer buf = {0};
    buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    buf.memory = V4L2_MEMORY_MMAP;
    buf.index = 0;
    if(-1 == xioctl(fd, VIDIOC_QUERYBUF, &buf))
    {
        perror("nepodarilo sa ziskat mmap buffer");
        return 1;
    }
 
    buffer = mmap (NULL, buf.length, PROT_READ | PROT_WRITE, MAP_SHARED, fd, buf.m.offset);
 
    return 0;
}

 
int detect_red(int fd)
{
    int pocitadlo = 0;
    struct v4l2_buffer buf = {0};
    buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    buf.memory = V4L2_MEMORY_MMAP;
    buf.index = 0;
    
#ifdef POUZI_YUV
    uint8_t *rgb = (uint8_t *)malloc(sirka * vyska * 3);
#endif

    if(-1 == xioctl(fd, VIDIOC_STREAMON, &buf.type))
    {
        perror("nepodarilo sa zapnut snimanie obrazu");
        return 1;
    }
 
    long long tm = usec();

    // cyklus zosnimania obrazku zopakujeme napr. 300-krat
    int pocet_opakovani = 300;
    for (int rep = 0; rep < pocet_opakovani; rep++)
    {
	    
      if(-1 == xioctl(fd, VIDIOC_QBUF, &buf))
      {
        perror("nepodarilo sa poziadat o buffer");
        return 1;
      }
      
      fd_set fds;
      FD_ZERO(&fds);
      FD_SET(fd, &fds);
      struct timeval tv = {0};
      tv.tv_sec = 2;
      int rv = select(fd+1, &fds, NULL, NULL, &tv);
      if(-1 == rv)
      {
          perror("pocas cakania na obrazok doslo k chybe");
          return 1;
      }
  
      if(-1 == xioctl(fd, VIDIOC_DQBUF, &buf))
      {
          perror("nepodarilo sa ziskat obrazok");
          return 1;
      }
      printf ("spracovavam obrazok %d... ", pocitadlo++);






int je_lopta(uint8_t r, uint8_t g, uint8_t b)
{

  float h, s, v, max, min;
  h = 0;
 
   if (r < b){
    if(r < g){
      min = r;
    }
    else{
      min = g;
    }
  }
  else{
    if (b < g){
      min = b;
    }
    else{
      min = g;
    }
  }



  if (r > b){
    if(r > g){
      max = r;
      if (max!= min){
        h = 60*((g-b)/(max-min));
      }
    }
    else{
      max = g;
      if (max!= min){
        h = 60*(2+(b-r)/(max-min));
      }
    }
  }
  else{
    if (b > g){
      max = b;
      if (max!= min){
        h = 60*(4+(r-g)/(max - min));
      } 
    }
    else{
      max = g;
      if (max!= min){
        h = 60*(2+(b-r)/(max - min));
      }
    }
  }
 
  v = max;

  s = (max-min)/max;
  if (h < 0){
    h = h + 360;
  }
  if (h < 28 && h > 8 && s > 0.5 && v > 100){
    return 1;
  }
  return 0;
}





#ifdef POUZI_YUV
      yuv422_to_rgb((uint8_t *)buffer, rgb, sirka, vyska);
      uint8_t *p = rgb;
#else
      uint8_t *p = (uint8_t *)buffer;
#endif
      double xs = 0;
      double ys = 0;
      int cnt = 0;
      // prechadzame cely obrazok bod po bode...
      // na tomto mieste chcete program upravit podla svojich potrieb...


x = 0;
y = 0;

      for (int i = 0; i < vyska; i++)
        for (int j = 0; j < sirka; j++)
        {
#ifdef POUZI_YUV
  	      uint8_t r = *(p++);
  	      uint8_t g = *(p++);
  	      uint8_t b = *(p++);
#else
  	      uint8_t b = *(p++);
  	      uint8_t g = *(p++);
  	      uint8_t r = *(p++);
#endif
  	      if (je_lopta(r,g,b) == 1)
              {
                cnt++;
                x = x + j;
                y = y + i;
              }
        }
      printf("%d oranzovych bodov\n", cnt);
    if (cnt == 0){
      printf("Nevidim\n");
    }
    else{
      x = x/cnt;
      y = y/cnt;
      printf("X: %f \n", x);
      printf("Y: %f \n", y);
    }
    }
    long long tm2 = usec();
    double cas = (tm2 - tm) / 1000000.0;
    printf("celkovy cas: %.2lf s (%.2lf fps)\n", cas, pocet_opakovani / (double)cas);
#ifdef POUZI_YUV
    free(rgb);
#endif
    return 0;
}
 
int main(int argc, char **argv)
{
        int fd;
	const char *device = "/dev/video0";
	if (argc > 1) device = argv[1];
 
        fd = open(device, O_RDWR);
        if (fd == -1)
        {
                perror("nepodarilo sa otvorit zariadenie /dev/videoN ...");
                return 1;
        }
        if(setup_format(fd))
            return 1;
        
        if(init_mmap(fd))
            return 1;
            
	detect_red(fd);

        close(fd);
        return 0;
}
