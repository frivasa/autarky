import json5
import json
import argparse
import sys


def update_nested_key(file_path, key_path, new_value):
    # Load JSON data
    try:
        with open(file_path, "r") as file:
            data = json5.load(file)
    except Exception as e:
        print(f"Error reading JSON file: {e}")
        sys.exit(1)

    # Traverse to the nested key
    d = data
    try:
        for key in key_path[:-1]:
            d = d[key]
        d[key_path[-1]] = new_value
    except KeyError:
        print(f"Error: Key path {' -> '.join(key_path)} not found.")
        sys.exit(1)
    except TypeError:
        print(f"Error: Encountered a non-dict while traversing the key path.")
        sys.exit(1)

    # Save the updated JSON back
    try:
        with open(file_path, "w") as file:
            json.dump(data, file, indent=2)
        print("Successfully updated the JSON file.")
    except Exception as e:
        print(f"Error writing to JSON file: {e}")
        sys.exit(1)


def main():
    parser = argparse.ArgumentParser(description="Update a nested key in a JSON file.")
    parser.add_argument("file", help="Path to the JSON file")
    parser.add_argument(
        "key_path", help="Nested key path, separated by dots (e.g., user.profile.name)"
    )
    parser.add_argument("path", help="path for value")
    parser.add_argument("new_value", help="New value for the nested key")

    args = parser.parse_args()

    # Split the dot-separated key path
    key_path = args.key_path.split(".")

    new_val = "/".join([args.path, args.new_value.split("/")[-1]])
    update_nested_key(args.file, key_path, new_val)


if __name__ == "__main__":
    main()
