FROM debian:bookworm-slim

# Install runtime and build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gnuradio-dev \
    git \
    cmake \
    build-essential \
    doxygen \
    python3-pip \
    python3-numpy \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Clone, build, and install gr-m17, then clean up build tools and files
RUN git clone --recursive https://github.com/M17-Project/gr-m17.git /gr-m17 \
    && cd /gr-m17 \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j$(nproc) \
    && make install \
    && cd / \
    && rm -rf /gr-m17 \
    && apt-get purge -y git cmake build-essential doxygen \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables for GNU Radio Companion and Python to find the installed modules
ENV LD_LIBRARY_PATH=/usr/local/lib/x86_64-linux-gnu/
ENV PYTHONPATH=/usr/local/lib/python3/dist-packages/

CMD [ "gnuradio-companion" ]
