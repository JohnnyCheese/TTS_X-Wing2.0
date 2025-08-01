-- Objective style token data, By Eirik W. Munthe (eirikmun)
local O = {}
O.scale = 3.63
O.token_width = 0.18 * O.scale
O.token_height = 0.151 * O.scale
O.token_nub_height = 0.029 * O.scale
O.token_nub_length = 0.031 * O.scale
O.point_height = 0.002 * O.scale
O.outline_points = {
    vector(-O.token_height, O.point_height, -O.token_width),
    vector(O.token_height, O.point_height, -O.token_width),
    vector(O.token_height + O.token_nub_height, O.point_height, -(O.token_width - O.token_nub_height)),
    vector(O.token_height + O.token_nub_height, O.point_height,
        -(O.token_width - O.token_nub_height - O.token_nub_length)),
    vector(O.token_height + 0.7 * O.token_nub_height, O.point_height,
        -(O.token_width - O.token_nub_height - 1.48 * O.token_nub_length)),
    vector(O.token_height, O.point_height, -(O.token_width - O.token_nub_height - 1.70 * O.token_nub_length)),
    vector(O.token_height, O.point_height, (O.token_width - O.token_nub_height - 1.70 * O.token_nub_length)),
    vector(O.token_height + 0.7 * O.token_nub_height, O.point_height,
        (O.token_width - O.token_nub_height - 1.48 * O.token_nub_length)),
    vector(O.token_height + O.token_nub_height, O.point_height, (O.token_width - O.token_nub_height - O.token_nub_length)),
    vector(O.token_height + O.token_nub_height, O.point_height, (O.token_width - O.token_nub_height)),
    vector(O.token_height, O.point_height, O.token_width),
    vector(-O.token_height, O.point_height, O.token_width),
    vector(-(O.token_height + O.token_nub_height), O.point_height, (O.token_width - O.token_nub_height)),
    vector(-(O.token_height + O.token_nub_height), O.point_height,
        (O.token_width - O.token_nub_height - O.token_nub_length)),
    vector(-(O.token_height + 0.7 * O.token_nub_height), O.point_height,
        (O.token_width - O.token_nub_height - 1.48 * O.token_nub_length)),
    vector(-(O.token_height), O.point_height, (O.token_width - O.token_nub_height - 1.70 * O.token_nub_length)),
    vector(-(O.token_height), O.point_height, -(O.token_width - O.token_nub_height - 1.70 * O.token_nub_length)),
    vector(-(O.token_height + 0.7 * O.token_nub_height), O.point_height,
        -(O.token_width - O.token_nub_height - 1.48 * O.token_nub_length)),
    vector(-(O.token_height + O.token_nub_height), O.point_height,
        -(O.token_width - O.token_nub_height - O.token_nub_length)),
    vector(-(O.token_height + O.token_nub_height), O.point_height, -(O.token_width - O.token_nub_height)),
}

O.hashmark_points = {
    left = vector(0, O.point_height, -O.token_width),
    right = vector(0, O.point_height, O.token_width),
    front = vector(O.token_height, O.point_height, 0),
    back = vector(-O.token_height, O.point_height, 0),

    frontleft = O.outline_points[2]:lerp(O.outline_points[3], 0.5),
    frontright = O.outline_points[10]:lerp(O.outline_points[11], 0.5),
    backleft = O.outline_points[20]:lerp(O.outline_points[1], 0.5),
    backright = O.outline_points[12]:lerp(O.outline_points[13], 0.5),
}

O.arc_line_segments = {}
O.arc_line_segments.full = {
    segments = {
        { O.outline_points[1],  O.outline_points[2] },
        { O.outline_points[2],  O.outline_points[3] },
        { O.outline_points[3],  O.outline_points[4] },
        { O.outline_points[4],  O.outline_points[5] },
        { O.outline_points[5],  O.outline_points[6] },
        { O.outline_points[6],  O.outline_points[7] },
        { O.outline_points[7],  O.outline_points[8] },
        { O.outline_points[8],  O.outline_points[9] },
        { O.outline_points[9],  O.outline_points[10] },
        { O.outline_points[10], O.outline_points[11] },
        { O.outline_points[11], O.outline_points[12] },
        { O.outline_points[12], O.outline_points[13] },
        { O.outline_points[13], O.outline_points[14] },
        { O.outline_points[14], O.outline_points[15] },
        { O.outline_points[15], O.outline_points[16] },
        { O.outline_points[16], O.outline_points[17] },
        { O.outline_points[17], O.outline_points[18] },
        { O.outline_points[18], O.outline_points[19] },
        { O.outline_points[19], O.outline_points[20] },
        { O.outline_points[20], O.outline_points[1] },
    },
    degrees = { direction = 0, spread = 180 }
}

O.arc_line_segments.fullback = {
    segments = {
        { O.hashmark_points.left, O.outline_points[2] },
        { O.outline_points[2],    O.outline_points[3] },
        { O.outline_points[3],    O.outline_points[4] },
        { O.outline_points[4],    O.outline_points[5] },
        { O.outline_points[5],    O.outline_points[6] },
        { O.outline_points[6],    O.outline_points[7] },
        { O.outline_points[7],    O.outline_points[8] },
        { O.outline_points[8],    O.outline_points[9] },
        { O.outline_points[9],    O.outline_points[10] },
        { O.outline_points[10],   O.outline_points[11] },
        { O.outline_points[11],   O.hashmark_points.right },
    },
    degrees = { direction = 90, spread = 90 }
}
O.arc_line_segments.fullfront = {
    segments = {
        { O.hashmark_points.right, O.outline_points[12] },
        { O.outline_points[12],    O.outline_points[13] },
        { O.outline_points[13],    O.outline_points[14] },
        { O.outline_points[14],    O.outline_points[15] },
        { O.outline_points[15],    O.outline_points[16] },
        { O.outline_points[16],    O.outline_points[17] },
        { O.outline_points[17],    O.outline_points[18] },
        { O.outline_points[18],    O.outline_points[19] },
        { O.outline_points[19],    O.outline_points[20] },
        { O.outline_points[20],    O.outline_points[1] },
        { O.outline_points[1],     O.hashmark_points.left },
    },
    degrees = { direction = -90, spread = 90 }
}

O.arc_line_segments.back = {
    segments = {
        { O.hashmark_points.frontleft, O.outline_points[3] },
        { O.outline_points[3],         O.outline_points[4] },
        { O.outline_points[4],         O.outline_points[5] },
        { O.outline_points[5],         O.outline_points[6] },
        { O.outline_points[6],         O.outline_points[7] },
        { O.outline_points[7],         O.outline_points[8] },
        { O.outline_points[8],         O.outline_points[9] },
        { O.outline_points[9],         O.outline_points[10] },
        { O.outline_points[10],        O.hashmark_points.frontright },
    },
    degrees = { direction = 90, spread = 44 }
}

O.arc_line_segments.front = {
    segments = {
        { O.hashmark_points.backright, O.outline_points[13] },
        { O.outline_points[13],        O.outline_points[14] },
        { O.outline_points[14],        O.outline_points[15] },
        { O.outline_points[15],        O.outline_points[16] },
        { O.outline_points[16],        O.outline_points[17] },
        { O.outline_points[17],        O.outline_points[18] },
        { O.outline_points[18],        O.outline_points[19] },
        { O.outline_points[19],        O.outline_points[20] },
        { O.outline_points[20],        O.hashmark_points.backleft },
    },
    degrees = { direction = -90, spread = 44 }
}

O.arc_line_segments.right = {
    segments = {
        { O.hashmark_points.backleft, O.outline_points[1] },
        { O.outline_points[1],        O.outline_points[2] },
        { O.outline_points[2],        O.hashmark_points.frontleft },
    },
    degrees = { direction = 0, spread = 45 }
}

O.arc_line_segments.left = {
    segments = {
        { O.hashmark_points.frontright, O.outline_points[11] },
        { O.outline_points[11],         O.outline_points[12] },
        { O.outline_points[12],         O.hashmark_points.backright },
    },
    degrees = { direction = 180, spread = 45 }
}

O.arc_line_segments.bullseye = nil


return O
