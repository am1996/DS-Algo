import time
import threading
import tkinter as tk
from tkinter import messagebox
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
import os

class RecursiveWatchHandler(FileSystemEventHandler):
    def __init__(self, observer):
        super().__init__()
        self.observer = observer

    def on_created(self, event):
        item_path = event.src_path
        if event.is_directory:
            print(f"📁 New directory created: {item_path}")
            # Start watching this new directory too
            self.observer.schedule(self, item_path, recursive=True)
            threading.Thread(target=show_popup, args=("Directory", item_path), daemon=True).start()
        else:
            print(f"📄 New file created: {item_path}")
            threading.Thread(target=show_popup, args=("File", item_path), daemon=True).start()

def show_popup(item_type, path):
    root = tk.Tk()
    root.withdraw()
    root.attributes('-topmost', True)
    messagebox.showinfo(f"New {item_type} Detected", f"A new {item_type.lower()} was added:\n\n{path}")
    root.destroy()

# === Configure your watch directory here ===
DIRECTORY_TO_WATCH = r"T:\2.AlandalousValidationWork\2. Qualification\camera_sabry"

if __name__ == "__main__":
    observer = Observer()
    event_handler = RecursiveWatchHandler(observer)

    # Watch the main directory recursively
    observer.schedule(event_handler, DIRECTORY_TO_WATCH, recursive=True)
    observer.start()
    print(f"🔍 Watching recursively for new files and folders in: {DIRECTORY_TO_WATCH}")

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
