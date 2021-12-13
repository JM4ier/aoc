const std = @import("std");
const List = std.ArrayList;

const data = @embedFile("../in.txt");

fn task2(nums: List(u32), alloc: *std.mem.Allocator, bias: u32, common: bool, init_mask: u32) !u32 {
    var in = List(bool).init(alloc);
    defer in.deinit();
    try in.appendNTimes(true, nums.items.len);

    var mask = init_mask;
    var count: usize = nums.items.len;
    var result: u32 = 0;

    while (count > 1 and mask != 0) {
        var ones: usize = 0;
        var i: usize = 0;
        while (i < nums.items.len) {
            if (0 != nums.items[i] & mask and in.items[i]) {
                ones += 1;
            }
            i += 1;
        }

        var retain1 = false;
        if (common == (2 * ones > count) and 2 * ones != count) {
            retain1 = true;
        } else if (2 * ones == count and bias == 1) {
            retain1 = true;
        }

        var retained: usize = 0;

        i = 0;
        while (i < nums.items.len) {
            in.items[i] = in.items[i] and ((nums.items[i] & mask != 0) == retain1);
            if (in.items[i]) {
                result = nums.items[i];
                retained += 1;
            }
            i += 1;
        }

        std.debug.print("retained {} values, bit: {}\n", .{retained, result & mask});

        count = retained;
        mask >>= 1;
    }

    return result;
}

pub fn main() !void {
    var alloc = std.heap.c_allocator;
    var lines = std.mem.tokenize(data, "\n");

    var nums = List(u32).init(alloc);
    defer nums.deinit();

    var mask : u32 = 0;

    while(lines.next()) |line| {
        var x : u32 = try std.fmt.parseInt(u32, line, 2);
        mask |= x;
        try nums.append(x);
    }

    var bits = List(u32).init(alloc);
    defer bits.deinit();

    var m2 = mask;
    while(m2 > 0) {
        try bits.append(0);
        m2 >>= 1;
    }

    for (nums.items) |*num| {
        var b : u32 = 0;
        var m : u32 = 1;
        while (b < bits.items.len) {
            if (num.* & m > 0) {
                bits.items[b] += 1;
            }
            b += 1;
            m <<= 1;
        }
    }

    var b : u32 = 0;
    var m : u32 = 1;
    var gamma : u32 = 0;

    while (b < bits.items.len) {
        if (bits.items[b] > nums.items.len / 2) {
            gamma |= m;
        }
        b += 1;
        m <<= 1;
    }

    var epsilon = (~gamma) & mask;
    var power = gamma * epsilon;
    std.debug.print("Task 1: {}\n", .{power});

    var imask = mask & ~(mask >> 1);
    var oxy = try task2(nums, alloc, 1, true, imask);
    var co2 = try task2(nums, alloc, 0, false, imask);

    std.debug.print("Task 2: {}\n", .{oxy * co2});

}
