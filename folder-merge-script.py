import os
import filecmp
import argparse
from pathlib import Path

def should_ignore(file_path):
    return file_path.name == '.DS_Store'

def merge_folders(source_folder, destination_folder, dry_run=False):
    source_path = Path(source_folder)
    dest_path = Path(destination_folder)
    actions = []

    for item in source_path.rglob('*'):
        if should_ignore(item):
            continue

        relative_path = item.relative_to(source_path)
        dest_item = dest_path / relative_path

        if item.is_file():
            if not dest_item.exists():
                actions.append(('copy', item, dest_item))
            elif not filecmp.cmp(item, dest_item, shallow=False):
                new_name = f"{dest_item.stem}_modified{dest_item.suffix}"
                new_dest = dest_item.with_name(new_name)
                counter = 1
                while new_dest.exists():
                    new_name = f"{dest_item.stem}_modified_{counter}{dest_item.suffix}"
                    new_dest = dest_item.with_name(new_name)
                    counter += 1
                actions.append(('rename_and_copy', item, new_dest))

    if dry_run:
        print("Dry run: The following actions would be performed:")
        for action, source, dest in actions:
            if action == 'copy':
                print(f"Copy: {source} -> {dest}")
            elif action == 'rename_and_copy':
                print(f"Rename and copy: {source} -> {dest}")
        print(f"Total actions: {len(actions)}")
    else:
        print("Performing merge:")
        for action, source, dest in actions:
            if action == 'copy':
                print(f"Copying: {source} -> {dest}")
                dest.parent.mkdir(parents=True, exist_ok=True)
                dest.write_bytes(source.read_bytes())
            elif action == 'rename_and_copy':
                print(f"Renaming and copying: {source} -> {dest}")
                dest.parent.mkdir(parents=True, exist_ok=True)
                dest.write_bytes(source.read_bytes())
        print(f"Merge completed. Total actions performed: {len(actions)}")

def main():
    parser = argparse.ArgumentParser(description="Merge two folders, handling duplicates and conflicts, ignoring .DS_Store files.")
    parser.add_argument("source", help="Path to the source folder")
    parser.add_argument("destination", help="Path to the destination folder")
    parser.add_argument("--dry-run", action="store_true", help="Perform a dry run without making any changes")
    
    args = parser.parse_args()
    
    merge_folders(args.source, args.destination, args.dry_run)

if __name__ == "__main__":
    main()
