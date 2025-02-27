import std.core;

enum CompressionType : u16 {
    none=0,
    clzw=2,
    clzw_in_crle=3,
    crle=4
};

struct Header {
   u32 magic;
   u16 framesCount;
   u16 bpp;
   u16 eventsCount;
   u8 someName[0xd];
   u32 fps;
   u32 flags;
   u8 transparency; // not verified
   u16 randomFramesNumber;
   padding[0xa];
   u32 authorLen;
   char author[authorLen];
   u32 descriptionLen;
   char description[descriptionLen];
};

struct Frame {
   padding[4];
   padding[4];
   s16 positionX;
   s16 positionY;
   padding[4];
   
   // not correct, there is more here (flags?)
   u32 hasSounds;
   
   padding[4];
   u8 transparency; // not verified
   padding[5];
   
   u32 nameLen;
   char name[nameLen];
   
   if (hasSounds != 0) {
      u32 sfxSize;
      char sounds[sfxSize];
   }
};

struct Event {
   char name[0x20];
   u16 framesCount;
   padding[6];
   u32 loopNumber;
   padding[2];
   u32 fps;
   u32 flags;
   u8 transparency;
   padding[0xc];
   
   u16 framesIds[framesCount];
   Frame frames[framesCount];
};

struct ANNImage {
   u16 width;
   u16 height;
   u16 positionX;
   u16 positionY;
   CompressionType compression;
   u32 imageLen;
   padding[4];
   padding[0xa];
   u32 alphaLen;
   char name[0x14];
};

struct ImageDataPair {
    u8 colorData[parent.annImages[std::core::array_index()].imageLen];
    u8 alphaData[parent.annImages[std::core::array_index()].alphaLen];
};

struct ANNFile {
   Header header;
   Event events[header.eventsCount];
   ANNImage annImages[header.framesCount];
   ImageDataPair images[header.framesCount];
};

ANNFile animo @ 0x00;
