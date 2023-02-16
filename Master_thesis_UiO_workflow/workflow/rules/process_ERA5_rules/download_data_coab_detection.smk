
rule download_EA_3hourly:
    output:
        outpath=config['intermediate_files']+"/CAOB_data/era5.{dataset}.{ERA5_vname}.3hourly.{sdate}-{edate}.nc"
    
    message: "downloading {output}"
    wildcard_constraints:
        dataset ="single_level|pressure_level"

    notebook: 
        "../../notebooks/download_ERA5/EA_singlelevels_download.py.ipynb"

rule retrive_all_data_CAOB_analysis:
    input:
        config['intermediate_files']+"/CAOB_data/era5.single_level.2m_temperature.3hourly.1989-2019.nc",
        config['intermediate_files']+"/CAOB_data/era5.single_level.mean_sea_level_pressure.3hourly.1989-2019.nc",
        config['intermediate_files']+"/CAOB_data/era5.pressure_level.vorticity.3hourly.1989-2019.nc",
        config['intermediate_files']+"/CAOB_data/era5.pressure_level.geopotential.3hourly.1989-2019.nc",
        

rule calc_CAOB_frequency:
    input:
        rules.retrive_all_data_CAOB_analysis.input
    output:
        outpath="figs/agu/COAB_frequency.png",
        csv = "results/COAB_table.csv"
    notebook:
        "../../notebooks/calc_CAOB_frequency.py.ipynb"


# rule create_CAOB_composite:
#     input:
#         table=rules.calc_CAOB_frequency.output.csv,
#         u_wind=rules.mean_sea_level_pressure_and_wind.input.u_wind,
#         v_wind=rules.mean_sea_level_pressure_and_wind.input.v_wind,
#         msl = rules.mean_sea_level_pressure_and_wind.input.msl,

#     outpath='results/composites/msl_pressure_wind_{plevel}/era5.wind_msl.{plevel}.composite.{kind}.{psize}.{season}.caob_index.{c}_{criterion}.{sdate}-{edate}.nc'

