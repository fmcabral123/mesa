
      subroutine eos_free_calc(
     &  ifestimate, morder, ifexchange_in,
     &  ifrad,
     &  nux, nuy, nuz, mion_end,
     &  n_partial_aux,
     &  sum0_mc, sum2_mc, hcon_mc, hecon_mc,
     &  partial_ions, 
     &  full_sum0, full_sum1, full_sum2, charge, charge2,
     &  dv_pl,
     &  ifdv, ifdvzero, ifcoulomb_mod, if_dc,
     &  ifsame_zero_abundances,
     &  ifexcited,
     &  naux, inv_aux,
     &  inv_ion, max_index,
     &  partial_elements, n_partial_elements, ion_end,
     &  ifionized, if_pteh, if_mc, ifreducedmass,
     &  ifsame_abundances, ifmtrace, iatomic_number,
     &  ifpi_local,
     &  ifpl, ifmodified, ifh2, ifh2plus,
     &  izlo, izhi, bmin,
     &  nmin, nmin_max, nmin_species, nmax,
     &  eps, tl, bi, h2diss, plop, plopt, plopt2,
     &  r_ion3, r_neutral, nelements, 
     &  ifelement, nion, nions,
     &  nextrasum, maxnextrasum,
     &  match_variable,
     &  fl, rhostar, pstar, sstar, ustar,
     &  f, wf, eta, n_e, rmue,
     &  h, hd, he, rl, h2plus,
     &  sum0, sum2, extrasum, xextrasum,
     &  index_ref)


      integer*4 nions_efca_dim, naux_efca_dim,
     &  nelements_efca_dim, maxcorecharge_efca_dim,
     &  nstar_efca_dim, nstarsmall_efca_dim,
     &  maxnextrasum_efca_dim, nxextrasum_efca_dim
      parameter(nions_efca_dim = 295)
      parameter(naux_efca_dim = 21)
      parameter(nelements_efca_dim = 20)
      parameter(maxcorecharge_efca_dim = 28)
      parameter(nstar_efca_dim = 9)
      parameter(nstarsmall_efca_dim = 3)
      parameter(maxnextrasum_efca_dim = 9)
      parameter(nxextrasum_efca_dim = 4)
      logical
     &  ifestimate, ifdvzero
      integer*4
     &  morder, ifexchange_in,
     &  ifrad,
     &  mion_end,
     &  n_partial_aux, partial_ions(nions_efca_dim+2),
     &  ifdv(nions_efca_dim+2), ifcoulomb_mod, if_dc,
     &  ifsame_zero_abundances,
     &  ifexcited,
     &  inv_aux(naux_efca_dim),
     &  inv_ion(nions_efca_dim+2), max_index,
     &  partial_elements(nelements_efca_dim+2),
     &  n_partial_elements,
     &  ion_end(nelements_efca_dim+2),
     &  ifionized, if_pteh, if_mc, ifreducedmass,
     &  ifsame_abundances, ifmtrace,
     &  iatomic_number(nelements_efca_dim), ifpi_local,
     &  ifpl, ifmodified, ifh2, ifh2plus,
     &  izlo, izhi,
     &  nmin(maxcorecharge_efca_dim),
     &  nmin_max(maxcorecharge_efca_dim),
     &  nmin_species(nions_efca_dim+2), nmax,
     &  ifelement(nelements_efca_dim), nion(nions_efca_dim+2),
     &  nextrasum, index_ref(nelements_efca_dim)
      real*8
     &  nux, nuy, nuz,
     &  sum0_mc, sum2_mc, hcon_mc, hecon_mc,
     &  full_sum0, full_sum1, full_sum2,
     &  charge(nions_efca_dim+2), charge2(nions_efca_dim+2),
     &  plop(nions_efca_dim+2), plopt(nions_efca_dim+2),
     &  plopt2(nions_efca_dim+2),
     &  dv_pl(nions_efca_dim+2),
     &  bmin(maxcorecharge_efca_dim),
     &  eps(nelements_efca_dim), tl, bi(nions_efca_dim+2), h2diss,
     &  r_ion3(nions_efca_dim+2), r_neutral(nelements_efca_dim+2),
     &  match_variable,
     &  fl, rhostar(nstar_efca_dim), pstar(nstar_efca_dim),
     &  sstar(nstarsmall_efca_dim), ustar(nstarsmall_efca_dim),
     &  f, wf, eta, n_e, rmue,
     &  h, hd, he, rl, h2plus,
     &  sum0, sum2,
     &  extrasum(maxnextrasum_efca_dim),
     &  xextrasum(nxextrasum_efca_dim)
      common/block_eos_free_calc_argument/
     &  nux, nuy, nuz,
     &  sum0_mc, sum2_mc, hcon_mc, hecon_mc,
     &  full_sum0, full_sum1, full_sum2,
     &  charge, charge2,
     &  plop, plopt,
     &  plopt2,
     &  dv_pl,
     &  bmin,
     &  eps, tl, bi, h2diss,
     &  r_ion3, r_neutral,
     &  match_variable,
     &  fl, rhostar, pstar,
     &  sstar, ustar,
     &  f, wf, eta, n_e, rmue,
     &  h, hd, he, rl, h2plus,
     &  sum0, sum2,
     &  extrasum,
     &  xextrasum,
     &  morder, ifexchange_in,
     &  ifrad,
     &  mion_end,
     &  n_partial_aux, partial_ions,
     &  ifdv, ifcoulomb_mod, if_dc,
     &  ifsame_zero_abundances,
     &  ifexcited,
     &  inv_aux,
     &  inv_ion, max_index,
     &  partial_elements,
     &  n_partial_elements,
     &  ion_end,
     &  ifionized, if_pteh, if_mc, ifreducedmass,
     &  ifsame_abundances, ifmtrace,
     &  iatomic_number, ifpi_local,
     &  ifpl, ifmodified, ifh2, ifh2plus,
     &  izlo, izhi,
     &  nmin,
     &  nmin_max,
     &  nmin_species, nmax,
     &  ifelement, nion,
     &  nextrasum, index_ref,
     &  ifestimate, ifdvzero