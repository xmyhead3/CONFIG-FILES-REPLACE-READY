function mkgif
    ffmpeg -i $argv[1] -vf "fps=10,scale=480:-1:flags=lanczos" -c:v gif $argv[1].gif
    echo "GIF created: $argv[1].gif"
end
