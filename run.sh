docker build -t gui_app .
docker run -d --name gui_app -p 2222:22 gui_app
