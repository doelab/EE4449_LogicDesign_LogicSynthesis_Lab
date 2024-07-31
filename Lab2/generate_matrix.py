#! /usr/bin/env python3
''' Create the matrixes (matri, matrices, whatever) for the Matrix Multiply
    project in EE4449.
'''
from argparse import ArgumentParser
from itertools import count
from random import randint

def main():
    ''' Do all the work here. '''
    parser = ArgumentParser(description="Generate random matrices for P2")
    parser.add_argument("mat_a", default="matA_gen.mif",
                        help="Matrix A .mif output")
    parser.add_argument("mat_b", default="matB_gen.mif",
                        help="Matrix B .mif output")
    parser.add_argument("mat_c", default="matC_gen.mif",
                        help="Matrix C .mif output")
    args = parser.parse_args()

    header_template = (
        "DEPTH = {depth};\n"
        "WIDTH = {width};\n"
        "ADDRESS_RADIX = HEX;\n"
        "DATA_RADIX = HEX;\n\n"
        "CONTENT BEGIN\n\n")

    footer_template = "\nEND;"

    matrix_dim = 128

    mat_a = [[randint(0, 0xff) for c in range(matrix_dim)]
             for r in range(matrix_dim)]
    mat_b = [randint(0, 0xff) for r in range(matrix_dim)]
    mat_c = [randint(0, 0xffff) for r in range(matrix_dim)]

    c_sum = 0
    ab_sum = 0

    for i in range(matrix_dim):
        for j in range(matrix_dim):
            ab_sum += mat_a[i][j] * mat_b[j]

        c_sum += mat_c[i]

    mma_product = ab_sum + c_sum

    with open(args.mat_a, "w") as fout:
        addr_counter = count(0)
        data_lines = [
            "{:04x} : {:02x};".format(next(addr_counter), e)
            for r in mat_a for e in r]

        a_depth = matrix_dim * matrix_dim
        fout.write(header_template.format(depth=a_depth, width=8) +
                   "\n".join(data_lines)
                   + footer_template)

    with open(args.mat_b, "w") as fout:
        addr_counter = count(0)
        data_lines = [
            "{:04x} : {:02x};".format(next(addr_counter), e)
            for e in mat_b]

        b_depth = matrix_dim
        fout.write(
            header_template.format(depth=b_depth, width=8) +
            "\n".join(data_lines) +
            footer_template)

    with open(args.mat_c, "w") as fout:
        addr_counter = count(0)
        data_lines = [
            "{:04x} : {:04x};".format(next(addr_counter), e)
            for e in mat_c]

        c_depth = matrix_dim
        fout.write(
            header_template.format(depth=c_depth, width=16) +
            "\n".join(data_lines) +
            footer_template)

    print("Matrix files created: {} {} {}".format(args.mat_a,
                                                  args.mat_b,
                                                  args.mat_c))

    print("Ab sum: 0x{:08x} (trunc {:06x})".format(ab_sum, ab_sum % (2 ** 24)))
    print("C sum: 0x{:08x} (trunc {:06x})".format(c_sum, c_sum % (2 ** 24)))
    print("MMA product: 0x{:08x} (trunc {:06x})".format(mma_product, mma_product % (2 ** 24)))

if __name__ == "__main__":
    main()
