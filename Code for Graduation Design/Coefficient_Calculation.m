function [Coef] = Coefficient_Calculation()
    %% 基本常数定义
    Hdr_PDCP = 2; Hdr_RLC = 5; Hdr_MAC = 2; IP_pkt = 1500;
    IP_DL_TTI = 6.2439; N_DL_TBS = 2; FAPI_DL = 1.5;
    N_SYM_SUB = 14; N_SC_RB = 12; N_UE = 1;
    Qm_PDSCH = 6; Qm_PCFICH = 2; Qm_PDCCH = 2; Layers_DL = 2;
    PDSCH_REs = 14400; PCFICH_REs = 16; PHICH_REs = 12; PDCCH_REs = 144;
    N_IQ = 32; N_CPRI = 32;
    %% 系数计算
    Coef(1) = IP_DL_TTI * IP_pkt * N_DL_TBS * 8 * 1000/1000000;
    Coef(2) = IP_DL_TTI * (IP_pkt + Hdr_PDCP) * N_DL_TBS * 8 * 1000/1000000;
    Coef(3) = IP_DL_TTI * (IP_pkt + Hdr_PDCP + Hdr_RLC) * N_DL_TBS * 8 * 1000/1000000;
    Coef(4) = (IP_DL_TTI * (IP_pkt + Hdr_PDCP + Hdr_RLC + Hdr_MAC) * N_DL_TBS * 8 * 1000/1000000) + FAPI_DL;
    Coef(5) = N_UE * PDSCH_REs * Qm_PDSCH * Layers_DL * 1000/1000000;
    Coef(6) = N_UE * PDSCH_REs * N_IQ * 1000/1000000;
    Coef(7) = N_SC_RB * N_SYM_SUB * N_IQ * 1000/1000000;
    Coef(8) = N_IQ;
    Coef(9) = N_CPRI * 10/8;
    Coef(10) = (PCFICH_REs * Qm_PCFICH + (PHICH_REs + PDCCH_REs * Qm_PDCCH)) * 1000/1000000;
    Coef(11) = (PCFICH_REs + PHICH_REs + PDCCH_REs) * N_IQ * 1000/1000000;
end
