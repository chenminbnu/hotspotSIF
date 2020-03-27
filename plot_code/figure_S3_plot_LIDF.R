library(ggplot2)
library(dplyr)
library(R.matlab)
library(ggpubr)
library(grid)
library(cowplot)

setwd('D://нр╣дндуб//SIF-GPP//results_code//SCOPE SA//data')

source('function.R')
sif_data <- readMat('different_LIDF_reshape.mat')


sif_data <- as.data.frame(sif_data[[1]])  
colnames(sif_data) <- c('SZA','vars', 'apar', "gpp",'sif_total',
                        'sif_hotspot','sif_hemi','sif_nadir',
                        'luep','sifyield','luef_hotspot','luef_hemi','luef_nadir',
                        'fesc_hotspot','fesc_hemi','fesc_nadir')
max_color <- 6
legend_title <- 'LIDF'

sif_data <- sif_data %>%
  mutate(fesc_total = 1)
## matrix to data.frame
# predefine parameter
#coord_cartesian(ylim = c(0, lim_y), xlim = c(0, lim_x))

# plot LUE

data <- sif_data[c("luef_hotspot","luep","vars")]
plot_hotspot_luep <- sa_plot_lue_lidf(data, expression(LUE[F]),expression(LUE[P]),0.01, 0.04,max_color,legend_title)

data <- sif_data[c("sifyield","luep","vars")]
plot_sifyield_luep <- sa_plot_lue_lidf(data, expression(Phi[F]),'',0.01, 0.04,max_color,legend_title) +  ylab(NULL) + 
  theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())

data <- sif_data[c("luef_nadir","luep","vars")]
plot_nadir_luep <- sa_plot_lue_lidf(data, expression(LUE[F]),'',0.01, 0.04,max_color,legend_title)+  ylab(NULL) + 
  theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())

data <- sif_data[c("luef_hemi","luep","vars")]
plot_hemi_luep <- sa_plot_lue_lidf(data, expression(LUE[F]),'',0.01, 0.04,max_color,legend_title)+  ylab(NULL) + 
  theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())

# plot GPP

data <- sif_data[c("sif_hotspot","gpp","vars")]
plot_hotspot_gpp <- sa_plot_other_lidf(data, expression(SIF~'('*mW~m^-2~nm^-1~sr^-1*')'),expression("GPP ("*umol~m^-2~s^-1*")"),5, 33,max_color,legend_title)

data <- sif_data[c("sif_nadir","gpp","vars")]
plot_nadir_gpp <- sa_plot_other_lidf(data, expression(SIF~'('*mW~m^-2~nm^-1~sr^-1*')'),'',5, 33,max_color,legend_title)+  ylab(NULL) + 
  theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())

data <- sif_data[c("sif_hemi","gpp","vars")]
plot_hemi_gpp <- sa_plot_other_lidf(data, expression(SIF~'('*mW~m^-2~nm^-1*')'),'',10.5, 33,max_color,legend_title)+  ylab(NULL) + 
  theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())

data <- sif_data[c("sif_total","gpp","vars")]
plot_sifyield_gpp <- sa_plot_other_lidf(data, expression(SIF~'('*mW~m^-2~nm^-1*')'),'',25, 33,max_color,legend_title)+  ylab(NULL) + 
  theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())

## plot escape ratio
data <- sif_data[c("SZA","fesc_hotspot","vars")]
data$fesc_hotspot <- data$fesc_hotspot*pi
plot_hotspot_fesc <- sa_plot_other_lidf(data, expression("SZA (║Ц)"),expression(f[esc]),90, 2,max_color,legend_title)
data <- sif_data[c("SZA","fesc_nadir","vars")]
data$fesc_nadir <- data$fesc_nadir*pi
plot_nadir_fesc <- sa_plot_other_lidf(data, expression("SZA (║Ц)"),'',90, 2,max_color,legend_title)+  ylab(NULL) +
  theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())
data <- sif_data[c("SZA","fesc_hemi","vars")]
data$fesc_hemi <- data$fesc_hemi;
plot_hemi_fesc <- sa_plot_other_lidf(data, expression("SZA (║Ц)"),'',90, 2,max_color,legend_title)+  ylab(NULL) +
  theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())
data <- sif_data[c("SZA","fesc_total","vars")]
data$fesc_total <- data$fesc_total;
plot_total_fesc <- sa_plot_other(data, expression("SZA (║Ц)"),'',90, 2,max_color,legend_title)+  ylab(NULL) + 
  theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())

# plot_total_fesc <- ggplot()+ theme_bw() +
#   theme(axis.line=element_blank(),
#         axis.text.x=element_blank(),
#         axis.text.y=element_blank(),
#         axis.ticks=element_blank(),
#         axis.title.x=element_blank(),
#         axis.title.y=element_blank(),
#         legend.position="none",
#         panel.background=element_blank(),
#         panel.border=element_blank(),
#         panel.grid.major=element_blank(),
#         panel.grid.minor=element_blank(),
#         plot.background=element_blank())+  ylab(NULL) + 
#   theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())





# results.tif <- ggarrange(plot_sifyield_luep,  plot_hotspot_luep, 
#                          plot_nadir_luep, plot_hemi_luep,
#                          plot_sifyield_gpp,  plot_hotspot_gpp, 
#                          plot_nadir_gpp, plot_hemi_gpp,
#                          plot_total_fesc,  plot_hotspot_fesc,
#                          plot_nadir_fesc, plot_hemi_fesc,
#                          labels = c("a", "","","","b", "","","","", "c","",""),font.label = list(size = 30, color = "black", face =
#                                                                                                    "bold", family = NULL),
#                          ncol = 4, nrow = 3, common.legend = TRUE, legend="right", align = "hv", vjust = 0)
# 
# 
# # Annotate the figure by adding a common labels
# results.tif <-  annotate_figure( results.tif,
#                 top = text_grob('Total', color = "black", face = "bold", size = 20, hjust = 8))
# results.tif <-  annotate_figure( results.tif,
#                                  top = text_grob('Hotspot', color = "black", face = "bold", size = 20, hjust = 2, vjust = 2))
# results.tif <-  annotate_figure( results.tif,
#                                  top = text_grob('Nadir', color = "black", face = "bold", size = 20, hjust = -2, vjust = 3.45))
# results.tif <-  annotate_figure( results.tif,
#                                  top = text_grob('Hemispherical', color = "black", face = "bold", size = 20, hjust = -2.15, vjust = 5))
# 
prow1 <- plot_grid(   plot_hotspot_luep+ theme(legend.position="none")  + ggtitle('Hotspot')+theme( plot.title=element_text(size=20,face="bold",hjust = 0.5)), 
                      plot_hotspot_fesc+ theme(legend.position="none"),
                      plot_hotspot_gpp+ theme(legend.position="none"), 
                      labels = c("a", "b","c"),
                      hjust = 0,
                      vjust = 0.8,
                      label_size = 25,
                      nrow = 3, ncol = 1, rel_heights = c(1, .9, .9), align = 'v')

prow2 <- plot_grid(   plot_nadir_luep+ theme(legend.position="none")  + ggtitle('Nadir')+theme( plot.title=element_text(size=20,face="bold",hjust = 0.5)), 
                      plot_nadir_fesc+ theme(legend.position="none"),
                      plot_nadir_gpp+ theme(legend.position="none"), 
                      nrow = 3, ncol = 1, rel_heights = c(1, .9, .9), align = 'v')
prow3 <- plot_grid(   plot_hemi_luep+ theme(legend.position="none")  + ggtitle('Hemispherical')+theme( plot.title=element_text(size=20,face="bold",hjust = 0.5)),
                      plot_hemi_fesc+ theme(legend.position="none"),
                      plot_hemi_gpp+ theme(legend.position="none"), 
                      nrow = 3, ncol = 1, rel_heights = c(1, .9, .9), align = 'v')
prow4 <- plot_grid(   plot_sifyield_luep+ theme(legend.position="none")  + ggtitle('Total')+theme( plot.title=element_text(size=20,face="bold",hjust = 0.5),  axis.title.y = element_text(face="bold", color="black",size=18)), 
                      plot_total_fesc+ theme(legend.position="none"),
                      plot_sifyield_gpp+ theme(legend.position="none"),
                      nrow = 3, ncol = 1, rel_heights = c(1, .9, .9), align = 'v')

# prow <- plot_grid(   plot_hotspot_luep+ theme(legend.position="none")  + ggtitle('Hotspot'), 
#                    plot_nadir_luep+ theme(legend.position="none")  + ggtitle('Nadir'), plot_hemi_luep+ theme(legend.position="none")  + ggtitle('Hemispherical'),
#                    plot_sifyield_luep+ theme(legend.position="none") + ggtitle('Total'),
#                    plot_hotspot_gpp+ theme(legend.position="none"), 
#                    plot_nadir_gpp+ theme(legend.position="none"), plot_hemi_gpp+ theme(legend.position="none"),plot_sifyield_gpp+ theme(legend.position="none"),  
#                      plot_hotspot_fesc+ theme(legend.position="none"),
#                    plot_nadir_fesc+ theme(legend.position="none"), plot_hemi_fesc+ theme(legend.position="none"),plot_total_fesc+ theme(legend.position="none"),
#                    labels = c("a", "","","","b", "","","","c", "","",""),
#                  
#                    hjust = -0.2,
#                    vjust = 1,
#                   label_size = 30,
#                    nrow = 3, ncol = 4, rel_heights = c(1, .9, .9), rel_widths = c(1,0.9,0.9,0.9))

prow <- plot_grid(prow1,prow2,prow3,prow4,
                  nrow = 1, ncol = 4, rel_widths = c(1,0.8,0.8,0.8))

legend_b <- get_legend(plot_sifyield_luep + theme(legend.position="right"))

results.tif <- plot_grid( prow, legend_b, ncol = 2, rel_widths = c(1, 0.2))

# results.tif1 <- ggarrange(plot_sifyield_luep, 
#                          plot_sifyield_gpp,
#                          plot_total_fesc,font.label = list(size = 30, color = "black", face = "bold", family = NULL),
#                          ncol = 1, nrow = 3, legend="none", align = "hv",labels = c("a","b", "c"))
# results.tif2 <- ggarrange( plot_hotspot_luep, 
#                           plot_hotspot_gpp, 
#                            plot_hotspot_fesc,
#                           font.label = list(size = 30, color = "black", face = "bold", family = NULL),
#                           ncol = 1, nrow = 3, legend="none", align = "hv")
# results.tif3 <- ggarrange(
#                           plot_nadir_luep,
#                           plot_nadir_gpp, 
#                           plot_nadir_fesc, 
#                           font.label = list(size = 30, color = "black", face = "bold", family = NULL),
#                           ncol = 1, nrow = 3, legend="none", align = "hv")
# results.tif4 <- ggarrange(plot_hemi_luep,
#                           plot_hemi_gpp, plot_hemi_fesc,
#                           font.label = list(size = 30, color = "black", face = "bold", family = NULL),
#                           ncol = 1, nrow = 3, common.legend = TRUE,legend="right", align = "hv")
# 
# # Annotate the figure by adding a common labels
# results.tif1 <-  annotate_figure( results.tif1,
#                                  top = text_grob('Total', color = "black", face = "bold", size = 20))
# results.tif2 <-  annotate_figure( results.tif2,
#                                  top = text_grob('Hotspot', color = "black", face = "bold", size = 20))
# results.tif3 <-  annotate_figure( results.tif3,
#                                  top = text_grob('Nadir', color = "black", face = "bold", size = 20))
# results.tif4 <-  annotate_figure( results.tif4,
#                                  top = text_grob('Hemispherical', color = "black", face = "bold", size = 20))
# 
# 
# results.tif <- ggarrange( results.tif1, results.tif2 , results.tif3, results.tif4 ,
#                          font.label = list(size = 30, color = "black", face =
#                                                                                                    "bold", family = NULL),
#                          ncol = 4, nrow = 1, common.legend = TRUE, legend="right", align = "hv")


ggsave("figure_S3_LIDF.tiff", plot = results.tif, width = 38, height = 25, units = "cm", dpi = 600, limitsize = FALSE, compression = "lzw")