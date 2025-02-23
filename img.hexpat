enum CompressionType : u32 {
    none=0,
    clzw=2,
    none2=4,
    jpegClzw=5
};

struct Header {
   u32 magic;
   u32 width;
   u32 height;
   u32 bpp;
   u32 imageLen;
   padding[4];
   CompressionType compression;
   u32 alphaLen;
   u32 positionX;
   u32 positionY;
};

struct IMGFile {
   Header header;
   u8 colorData[header.imageLen];
   u8 alphaData[header.alphaLen];
};

IMGFile image @ 0x00;