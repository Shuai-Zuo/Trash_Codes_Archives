using System;
using BepInEx;
using RoR2;


namespace Mod
{
    [BepInPlugin("com.Go.FirstTest", "FirstTest", "1.2.1")]
    public class changePercentages : BaseUnityPlugin
    {
        private int a;
        private float b;

        public changePercentages()
        {
            On.RoR2.ChestBehavior.ItemDrop += ChestBehavior_ItemDrop;
            On.RoR2.ChestBehavior.Start += ChestBehavior_Start;
        }


        private void ChestBehavior_Start(On.RoR2.ChestBehavior.orig_Start orig, ChestBehavior self)
        {
            orig(self);
            a = 0;
            b = 0f;
            self.tier1Chance = 0.7f;
            self.tier2Chance = 0.2f;
            self.tier3Chance = 0.1f;
        }

        private void ChestBehavior_ItemDrop(On.RoR2.ChestBehavior.orig_ItemDrop orig, ChestBehavior self)
        {
            int i;
            Random rc = new Random();
            i = rc.Next(100);
            a = a + 1;
            if (b < 0.15f)
                b = b + 0.01f;
            self.tier1Chance = 0.7f - b;
            self.tier2Chance = 0.2f;
            self.tier3Chance = 0.1f + b;
            do
            {
                orig(self);
                self.RollItem();
                orig(self);
                self.RollItem();
                i = rc.Next(100);
                if (a == 1)
                {
                    self.tier1Chance = 0f;
                    self.tier2Chance = 0f;
                    self.tier3Chance = 1f;
                    self.lunarChance = 0f;
                    self.RollItem();
                    orig(self);
                    self.tier1Chance = 0.7f - b;
                    self.tier2Chance = 0.2f;
                    self.tier3Chance = 0.1f + b;
                    self.lunarChance = 0f;
                    self.RollItem();
                    a = 2;
                    i = 100;
                }
                if (a >= 4)
                {
                    self.tier1Chance = 0f;
                    self.tier2Chance = 0f;
                    self.tier3Chance = 0f;
                    self.lunarChance = 1f;
                    self.RollItem();
                    orig(self);
                    self.tier1Chance = 0.7f - b;
                    self.tier2Chance = 0.2f;
                    self.tier3Chance = 0.1f + b;
                    self.lunarChance = 0f;
                    self.RollItem();
                    a = 0;
                    i = 100;
                }
            } while (i > 65);
        }
    }
}
