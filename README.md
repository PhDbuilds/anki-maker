# Anki-Maker

Welcome to **Anki-Maker**, a simple script + AI pattern combo for automatically generating Anki flashcards from your notes. This project uses [Fabric](https://github.com/danielmiessler/fabric) to feed text into a custom “to_anki” pattern, transforming plain markdown notes into CSV files ready for Anki import.

---

## Why Anki-Maker?
Time is money—especially if you’re studying for certs like CompTIA, juggling work, and trying to have a life. Manually converting every note you take into flashcards is tedious. **Anki-Maker** solves that by letting you:

1. Batch-process markdown files (using a prefix-based system).
2. Automatically turn them into Q&A pairs based on the [Minimum Information Principle](https://www.supermemo.com/en/archives1990-2015/articles/20rules) and spaced-repetition best practices.
3. Effortlessly load them into Anki for next-level memory retention.

---

## How It Works
1. **Prefix-based Organization**  
   - Keep your markdown notes organized by using a prefix (e.g., `LM1_`, `SecM1_`, etc.). For these examples, this prefix would be short for Linux Module 1 or Security+ Module 1 where all Module 1 notes are linked from.
   - This helps the script find all related files without going through the rest of your unrelated notes.

2. **Fabric "to_anki" Pattern**  
   - We provide a custom pattern (`systemd.md`) that tells Fabric how to split the text into questions and answers.  
   - It outputs a pipe-delimited CSV, which is super convenient to import into Anki (commas can be messy if your text includes commas).

3. **Batch Conversion**  
   - Our Bash script (`anki-maker.sh`) looks for every `.md` file with your chosen prefix, sends each file’s contents into Fabric, and appends all generated flashcards to a single CSV file.  
   - In a matter of seconds, you’ve got a tidy Q&A set for Anki.

---

## Requirements
- **Bash** (for the main script)
- **Fabric** by Daniel Miessler. Check out [his GitHub repo](https://github.com/danielmiessler/fabric) for instructions on installing and setting up your API keys.
- A working Anki installation, obviously. (Though you could technically use the CSV anywhere that needs Q&A pairs.)

---

## Installation & Setup
1. **Clone this repo**:
   ```bash
   git clone https://github.com/phdbuilds/anki-maker.git
   cd anki-maker
   ```
2. **Install Fabric**:
   - Follow the official Fabric instructions found [here](https://github.com/danielmiessler/fabric).
3. **Update the Script**:
   - Open `anki-maker.sh` in your favorite text editor.
   - Modify the `notes_dir` and `anki_dir` variables to point to your actual note storage path and the directory where you want the CSV file.
4. **Check the Pattern**:
   - The custom pattern file is `system.md`. Make sure you’re cool with the instructions in there. You can tweak how the questions and answers get formatted to suit your style. You will need to create a to_anki directory within Fabric's patterns.

---

## Usage
1. **Prefix Your Notes**  
   - Suppose you have a bunch of notes named `LM1-topic1.md`, `LM1-topic2.md`, etc., in `/path/to/notes`.
2. **Run the Script**:  
   ```bash
   ./anki-maker.sh LM1
   ```
   This command will:
   - Find all `.md` files starting with `LM1` inside `/path/to/notes`.  
   - Pipe each file’s content into Fabric using the `to_anki` pattern.  
   - Append the CSV output to a single file named `LM1_final.txt` (or whatever prefix you used).
3. **Import into Anki**:
   - Open Anki, create a new deck (if you want).  
   - Click **File** > **Import**, select `LM1_final.txt` (or the equivalent), and set the field separator to `|`.  
   - Verify that it shows two columns. Then hit **Import**. Boom, you’re done!

---

## Example
If you have notes like:

```bash
/path/to/notes
 ├── LM1-lesson1.md
 ├── LM1-lesson2.md
 ├── LM1-review.md
```

Running:

```bash
./anki-maker.sh LM1
```

Will produce a file called `LM1_final.txt` with lines like:

```
What command is used to create a system group|groupadd -r
Which command renames a user account|usermod -l newname oldname
...
```

---

## Advanced Stuff
- **Custom Patterns**: You can create multiple pattern files for different output formats (say, if you want multiple choice vs. Q&A). Just update the script to point to the new pattern.
- **Token Limits**: Watch out if your notes are super large; sometimes the AI can choke if you exceed certain token limits. That’s partly why the prefix-based approach is so handy. This and I like to take modular notes that are linked together like this anyways, so adding the prefix to the alreayd created notes was an easy transition for me, and most others using Obsidian anyways.

---

## Future Enhancements
- **Selenium Scraping**: Planning on using a web driver to log in to sites like CompTIA CertMaster, scrape the raw text, and feed it to Fabric so you can bypass note-taking for brute memorization. (Obviously, you’ll still want to do your own note-taking for more conceptual stuff.)
- **UI Integration**: Thinking about adding a small UI or TUI (terminal user interface) so you don’t have to remember any command-line arguments.
- **Error Handling**: Possibly refining how the script handles files that might break the pipe delimiter with extra `|` or weird formatting.

---

## Contributing
If you’d like to contribute:
1. Fork the repo
2. Create a new branch (`git checkout -b feature/my-feature`)
3. Commit your changes
4. Push to your branch and open a Pull Request

---

## Contact
If you have any questions, suggestions, or just want to say hi, feel free to open an issue or shoot a message my way. Happy Anki-making!

---
