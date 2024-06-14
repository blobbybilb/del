import PyPDF2
import sys

def reorder_pages(input_file, output_file):
    with open(input_file, 'rb') as input_pdf:
        reader = PyPDF2.PdfReader(input_pdf)
        total_pages = len(reader.pages)
        
        if total_pages % 2 != 0:
            print("The number of pages should be even.")
            sys.exit(1)
        
        half = total_pages // 2
        odd_pages = reader.pages[:half]
        even_pages = reader.pages[half:]

        output_pdf = PyPDF2.PdfWriter()

        for i in range(half):
            output_pdf.add_page(odd_pages[i])
            output_pdf.add_page(even_pages[half - i - 1])

        with open(output_file, 'wb') as output:
            output_pdf.write(output)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python reorder_pages_single_pdf.py <input_pdf> <output_pdf>")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    reorder_pages(input_file, output_file)
