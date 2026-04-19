const std = @import("std");

const Module = std.Build.Module;
const ResolvedTarget = std.Build.ResolvedTarget;
const OptimizeMode = std.builtin.OptimizeMode;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const NAME = "prompt";
    const suffix = switch (optimize) {
        .Debug => "-dbg",
        .ReleaseFast => "",
        .ReleaseSafe => "-s",
        .ReleaseSmall => "-sm",
    };

    var name_buf: [NAME.len + 4]u8 = undefined;
    const bin_name = std.fmt.bufPrint(@constCast(&name_buf), "{s}{s}", .{ NAME, suffix }) catch unreachable;

    const lib_module = b.addModule(NAME, .{ .root_source_file = b.path("src/" ++ NAME ++ ".zig"), .target = target });
    const zut_dep = b.dependency("zut", .{ .target = target, .optimize = optimize });
    lib_module.addImport("zut", zut_dep.module("zut"));

    const main_module = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    main_module.addImport("zut", zut_dep.module("zut"));
    main_module.addImport(NAME, lib_module);

    const exe = b.addExecutable(.{ .name = bin_name, .root_module = main_module });
    b.installArtifact(exe);

    const check = b.addExecutable(.{ .name = bin_name, .root_module = main_module });
    const check_step = b.step("check", "Build for LSP Diagnostics");
    check_step.dependOn(&check.step);

    const mod_tests = b.addTest(.{ .name = NAME, .root_module = main_module });
    const run_mod_tests = b.addRunArtifact(mod_tests);
    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_mod_tests.step);
    check_step.dependOn(&run_mod_tests.step);
}
