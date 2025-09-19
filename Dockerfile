FROM ubuntu:24.04

# Install runtime dependencies and build tools
RUN apt-get update && apt-get install -y \
    gnuradio \
    git \
    cmake \
    build-essential \
    doxygen \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Clone and build gr-m17, then remove build tools
RUN git clone --recursive https://github.com/M17-Project/gr-m17.git /gr-m17 \
    && cd /gr-m17 \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j$(nproc) \
    && make install \
    && cd / \
    && rm -rf /gr-m17 \
    && apt-get purge -y \
       git \
       cmake \
       build-essential \
       doxygen \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables for GNU Radio Companion
ENV LD_LIBRARY_PATH=/usr/local/lib/x86_64-linux-gnu/
ENV PYTHONPATH=/usr/local/lib/python3.11/dist-packages/
