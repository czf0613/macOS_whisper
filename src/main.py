import mlx_whisper
import tkinter as tk
from tkinter import filedialog, messagebox
import subprocess
import os
from typing import List, Optional, Dict, Union


def trascribe_audio(input: str) -> Optional[List[Dict[str, Union[str, float]]]]:
    try:
        result = mlx_whisper.transcribe(
            input,
            path_or_hf_repo="whisper-large-v3-mlx",
            verbose=True,
            # no_speech_threshold=0.6,
            # logprob_threshold=-1,
            language="zh",
        )

        return result["segments"]
    except Exception as e:
        print(f"Error: {e}")
        return None


def format_second(sec: float) -> str:
    hours = int(sec // 3600)
    minutes = int((sec % 3600) // 60)
    seconds = int(sec % 60)
    milliseconds = int((sec - int(sec)) * 1000)
    return f"{hours:02}:{minutes:02}:{seconds:02},{milliseconds:03}"


def write_srt(segments: List[Dict[str, Union[str, float]]], srt_file: str):
    line_sep = "\r\n"
    cnt = 1

    with open(srt_file, "w") as f:
        for i in segments:
            if i["text"].strip() == "":
                continue

            f.write(f"{cnt}{line_sep}")
            cnt += 1

            f.write(
                f"{format_second(i['start'])} --> {format_second(i['end'])}{line_sep}"
            )
            f.write(f"{i['text']}{line_sep}")
            f.write(line_sep)


if __name__ == "__main__":
    window = tk.Tk()
    window.withdraw()

    video_file = filedialog.askopenfilename(
        title="选择视频", filetypes=[("视频文件", "*.mp4 *.mov")]
    )
    if video_file == "":
        print("没有选择视频文件")
        exit(1)

    # 提取音频
    speech_file = "work_cache/test.wav"
    subprocess.run(
        [
            "ffmpeg",
            "-y",
            "-i",
            video_file,
            "-vn",
            "-ac",
            "1",
            "-ar",
            "16000",
            "-c:a",
            "pcm_s16le",
            speech_file,
        ]
    )

    # 语音识别
    segs = trascribe_audio(speech_file)
    if segs is None or len(segs) == 0:
        messagebox.showerror("错误", "无法完成语音转写")
        exit(2)

    # 保存结果
    srt_file = filedialog.asksaveasfilename(
        title="保存字幕文件", defaultextension=".srt", initialfile="output"
    )
    if srt_file == "":
        srt_file = "work_cache/output.srt"
        print(f"没有选择保存文件，使用默认路径：{srt_file}")

    window.destroy()
    write_srt(segs, srt_file)

    # 打开finder到保存目录
    abs_path = os.path.abspath(srt_file)
    parent_dir = os.path.dirname(abs_path)
    subprocess.run(["open", parent_dir])
