import os
import uvicorn
import signal
from dotenv import load_dotenv

from app.main import app

load_dotenv()

host = os.getenv('HOST')
port = os.getenv('PORT')
environment = os.getenv('ENVIRONMENT')

def handle_signal(signum, frame):
    print(f"Received signal {signum} - shutting down server gracefully")
    uvicorn.stop()

# Register signal handlers
signal.signal(signal.SIGINT, handle_signal)  # Ctrl+C
signal.signal(signal.SIGTERM, handle_signal) # SIGTERM

if __name__ == '__main__':

    if environment == 'LOCAL':
        uvicorn.run(app, host=host, port=int(port))
    else:
        uvicorn.run(app, host='0.0.0.0', port=8081)
