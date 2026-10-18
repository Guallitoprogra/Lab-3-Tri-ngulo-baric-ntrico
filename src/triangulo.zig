const std = @import("std");

pub const Punto = struct { x: f64, y: f64 };

fn areaDoble(a: Punto, b: Punto, c: Punto) f64 {
    return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
}

pub fn coordenadas(a: Punto, b: Punto, c: Punto, p: Punto) ?[3]f64 {
    const total = areaDoble(a, b, c);
    if (total == 0) return null;
    return .{
        areaDoble(p, b, c) / total,
        areaDoble(a, p, c) / total,
        areaDoble(a, b, p) / total,
    };
}

pub fn color(a: Punto, b: Punto, c: Punto, p: Punto) ?[3]u8 {
    const pesos = coordenadas(a, b, c, p) orelse return null;
    for (pesos) |peso| {
        if (peso < -1e-10) return null;
    }
    var rgb: [3]u8 = undefined;
    for (pesos, 0..) |peso, i| {
        rgb[i] = @intFromFloat(@round(std.math.clamp(peso, 0, 1) * 255));
    }
    return rgb;
}
