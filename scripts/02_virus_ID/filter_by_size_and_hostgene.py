import sys

def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        return False

def filter_lines(input_file, output_file):
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        for line in infile:
            columns = line.strip().split('\t')
            if is_number(columns[1]) and is_number(columns[6]):
                if int(columns[1]) > 10000 and float(columns[6]) <= 1:
                    outfile.write(line)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py <input_file> <output_file>")
    else:
        input_file = sys.argv[1]
        output_file = sys.argv[2]
        filter_lines(input_file, output_file)
        print(f"Filtered lines have been written to {output_file}.")