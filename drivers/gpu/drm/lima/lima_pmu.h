/* SPDX-License-Identifier: GPL-2.0 OR MIT */
/* Copyright 2017-2018 Qiang Yu <yuq825@gmail.com> */

#ifndef __LIMA_PMU_H__
#define __LIMA_PMU_H__

struct lima_ip;

int lima_pmu_init(struct lima_ip *ip);
void lima_pmu_fini(struct lima_ip *ip);

#endif
