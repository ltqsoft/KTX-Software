// -*- tab-width: 4; -*-
// vi: set sw=2 ts=4 expandtab:

//
// ©2010 The Khronos Group, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

//!
//! @internal
//! @~English
//! @file
//!
//! @brief Create Images from JPEG format files.
//!
//! @author Mark Callow, HI Corporation.
//! @author Jacob Str&ouml;m, Ericsson AB.
//!

#include "stdafx.h"

#include <sstream>
#include <stdexcept>

#include "image.hpp"
#include "jpgd.h"

using namespace jpgd;

class myjpgdstream : public jpeg_decoder_file_stream {
  public:
    myjpgdstream(FILE* stdioStream) {
        m_pFile = stdioStream;
        m_eof_flag = false;
        m_error_flag = false;
    }

    int read(uint8_t* pBuf, int max_bytes_to_read, bool* pEOF_flag) {
        if (!m_pFile)
          return -1;

        if (m_eof_flag)
        {
          *pEOF_flag = true;
          return 0;
        }

        if (m_error_flag)
          return -1;

        size_t bytes_read = fread(pBuf, 1, max_bytes_to_read, m_pFile);
        if (bytes_read < max_bytes_to_read)
        {
          if (ferror(m_pFile))
          {
            m_error_flag = true;
            return -1;
          }

          m_eof_flag = true;
          *pEOF_flag = true;
        }

        return static_cast<int>(bytes_read);
    }

    void rewind() { ::rewind(m_pFile); }

  protected:
   FILE*  m_pFile;
   bool m_eof_flag, m_error_flag;
};

// All JPEG files are sRGB.
Image*
Image::CreateFromJPG(FILE* src, bool)
{
    myjpgdstream stream(src);
    uint32_t componentCount;

    // Figure out how many components so we can request that number from
    // the decoder.
    {
        jpeg_decoder jd(&stream, jpeg_decoder::cFlagLinearChromaFiltering);
        jpgd_status errorCode = jd.get_error_code();

        if (errorCode != JPGD_SUCCESS) {
            if (errorCode == JPGD_NOT_JPEG) {
                throw Image::different_format();
            } else if (errorCode == JPGD_NOTENOUGHMEM) {
                throw std::runtime_error("JPEG decoder out of memory");
            } else {
                std::stringstream message;
                message << "Invalid data in JPEG file. jpgd_status code: "
                        << strerror(ferror(src));
                throw std::runtime_error(message.str());
            }
        }
        componentCount = jd.get_num_components();
    }
    // The decoder is now closed. We don't use it because it's a per scan line
    // thing so needs a lot of code, which is in the following function.

    stream.rewind();

    int w = 0, h = 0, actual_comps = 0;
    uint8_t* imageData = decompress_jpeg_image_from_stream(&stream,
                              &w, &h, &actual_comps, componentCount,
                              jpeg_decoder::cFlagLinearChromaFiltering);

    if (imageData == NULL) {
         throw std::runtime_error("JPEG decode failed");
    }

    uint32_t pixelCount = w * h;
    Image* image;
    switch (componentCount) {
      case 1: {
        using Color = color<uint8_t, 1>;
        image = new ImageT< Color, PreAllocator<Color> >(w, h, (Color*)imageData, pixelCount);
        break;
      } case 3: {
        using Color = color<uint8_t, 3>;
        image = new ImageT< Color, PreAllocator<Color> >(w, h, (Color*)imageData, pixelCount);
        break;
      } case 4: {
        using Color = color<uint8_t, 4>;
        image = new ImageT< Color, PreAllocator<Color> >(w, h, (Color*)imageData, pixelCount);
        break;
      }
    }

    // All JPEG images are sRGB.
    image->setOetf(Image::eOETF::sRGB);
    return image;
}

