docker run --gpus all --name tfcode --restart always -p 3000:8888 -u $(id -g):$(id -g) -e PASSWORD=$PASSWORD -d -v $(pwd):/home/tf-docker tfcode
